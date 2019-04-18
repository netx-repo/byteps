// Copyright 2019 ByteDance Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// =============================================================================

#include <cstring>
#include <memory>
#include <thread>
#include <chrono>

#include "operations.h"

namespace byteps {
namespace common {

bool RunReduceLoopOnce() {
    auto q = BytePSGlobal::GetScheduledQueue(REDUCE);
    while (q->pendingSize() > 0) {
        auto task = q->getTask();
        BPS_LOG(TRACE) << "Finish reducing tensor: " << task->tensor_name;
        CHECK(task->tensor);

        EnqueueTensorPush(task->context, task->tensor, nullptr, task->tensor_name,
            task->key, task->device, task->priority, task->version, task->callback);
    }
    return true;
}

bool RunPushLoopOnce() {
    auto q = BytePSGlobal::GetScheduledQueue(PUSH);
    while (q->pendingSize() > 0) {
        // TODO: allow merging
        auto task = q->getTask();
        CHECK(task->tensor);

        // get metadata
        size_t size = task->tensor->size();
        const int dtype = task->tensor->dtype();

        auto& keys = task->keys;

        char* data = const_cast<char*> (static_cast<const char*> (task->tensor->data()));
        // false means not to delete data when SArray is deleted
        ps::SArray<char> vals(data, size, false);

        auto& lens = task->lens;

        int cmd = GetCommandType(RequestType::kDefaultPushPull, dtype);

        BytePSGlobal::GetPS()->ZPush(
            keys, vals, lens, cmd,
            [task]() {
                BPS_LOG(TRACE) << "Finish pushing tensor: " << task->tensor_name;
                EnqueueTensorPull(task->context, task->tensor, nullptr, task->tensor_name,
                    task->key, task->device, task->priority, task->version, task->callback);
            }
        );
    }
    return true;
}

bool RunPullLoopOnce() {
    auto q = BytePSGlobal::GetScheduledQueue(PULL);
    while (q->pendingSize() > 0) {
        // TODO: allow merging
        auto task = q->getTask();
        CHECK(task->output);

        // get metadata
        size_t size = task->output->size();
        const int dtype = task->output->dtype();

        auto& keys = task->keys;

        char* data = const_cast<char*>(static_cast<const char*> (task->output->data()));
        // false means not to delete data when SArray is deleted
        auto vals = new ps::SArray<char>(data, size, false);

        auto& lens = task->lens;

        int cmd = GetCommandType(RequestType::kDefaultPushPull, dtype);

        // issue pull
        BytePSGlobal::GetPS()->ZPull(
            keys, vals, &lens, cmd,
            [vals, task]() {
                delete vals;
                BPS_LOG(TRACE) << "Finish pulling tensor: " << task->tensor_name;
                EnqueueTensorBroadcast(task->context, task->output, nullptr, task->tensor_name,
                    task->key, task->device, task->priority, task->version, task->callback);
            });
    }
    return true;
}

bool RunBroadcastLoopOnce() {
    auto q = BytePSGlobal::GetScheduledQueue(BROADCAST);
    while (q->pendingSize() > 0) {
        auto task = q->getTask();
        CHECK(task->output);
        BPS_LOG(TRACE) << "Finish broadcasting tensor: " << task->tensor_name;
        task->callback(Status::OK());
    }
    return true;
}

void ReduceLoop() {
    while (RunReduceLoopOnce() && !BytePSGlobal::ShouldShutdown()) {
        std::this_thread::sleep_for(std::chrono::nanoseconds(1000));
    }
}

void PushLoop() {
    while (RunPushLoopOnce() && !BytePSGlobal::ShouldShutdown()) {
        std::this_thread::sleep_for(std::chrono::nanoseconds(1000));
    }
}

void PullLoop() {
    while (RunPullLoopOnce() && !BytePSGlobal::ShouldShutdown()) {
        std::this_thread::sleep_for(std::chrono::nanoseconds(1000));
    }
}

void BroadcastLoop() {
    while (RunBroadcastLoopOnce() && !BytePSGlobal::ShouldShutdown()) {
        std::this_thread::sleep_for(std::chrono::nanoseconds(1000));
    }
}

extern "C" {

void byteps_init() {
    BytePSGlobal::Init();
    LoopFunction func[ThreadNum] = {ReduceLoop, PushLoop, PullLoop, BroadcastLoop};
    BytePSGlobal::Start(func);
    return;
}

void byteps_shutdown() {
    BytePSGlobal::Shutdown();
    BPS_LOG(TRACE) << "BytePS is shutdown.";
    return;
}

int byteps_rank() {
    return BytePSGlobal::GetRank();
}

int byteps_local_rank() {
    return BytePSGlobal::GetLocalRank();
}

int byteps_size() {
    return BytePSGlobal::GetSize();
}

int byteps_local_size() {
    return BytePSGlobal::GetLocalSize();
}

} // extern "C"

Status CheckInitialized() {
    return BytePSGlobal::CheckInit();
}

Status EnqueueTensorReduce(std::shared_ptr<OpContext> context,
                        std::shared_ptr<Tensor> input,
                        std::shared_ptr<ReadyEvent> ready_event,
                        const std::string &name, ps::Key key,
                        const int device, const int priority, const int version,
                        StatusCallback callback) {
    std::shared_ptr<TensorTableEntry> e(new TensorTableEntry);
    e->tensor_name = name;
    e->key = key;
    e->context = context;
    e->tensor = input;
    e->output = NULL;
    e->ready_event = ready_event;
    e->device = device;
    e->priority = priority;
    e->version = version;
    e->callback = callback;

    CHECK(e->tensor);
    e->keys.push_back(key);
    e->lens.push_back(e->tensor->size());

    BPS_LOG(TRACE) << "EnqueueTensorReduce: " << e->tensor_name
                   << ", key=" << e->key
                   << ", size=" << e->tensor->size()
                   << ", device=" << device;
    BytePSGlobal::GetScheduledQueue(REDUCE)->addTask(e);
    return Status::OK();
}

Status EnqueueTensorPush(std::shared_ptr<OpContext> context,
                        std::shared_ptr<Tensor> input,
                        std::shared_ptr<ReadyEvent> ready_event,
                        const std::string &name, ps::Key key,
                        const int device, const int priority, const int version,
                        StatusCallback callback) {
    std::shared_ptr<TensorTableEntry> e(new TensorTableEntry);
    e->tensor_name = name;
    e->key = key;
    e->context = context;
    e->tensor = input;
    e->output = NULL;
    e->ready_event = ready_event;
    e->device = device;
    e->priority = priority;
    e->version = version;
    e->callback = callback;

    CHECK(e->tensor);
    e->keys.push_back(key);
    e->lens.push_back(e->tensor->size());

    BPS_LOG(TRACE) << "EnqueueTensorPush: " << e->tensor_name
                   << ", key=" << e->key
                   << ", size=" << e->tensor->size()
                   << ", device=" << device;
    BytePSGlobal::GetScheduledQueue(PUSH)->addTask(e);
    return Status::OK();
}

Status EnqueueTensorPull(std::shared_ptr<OpContext> context,
                        std::shared_ptr<Tensor> output,
                        std::shared_ptr<ReadyEvent> ready_event,
                        const std::string &name, ps::Key key,
                        const int device, const int priority, const int version,
                        StatusCallback callback) {
    std::shared_ptr<TensorTableEntry> e(new TensorTableEntry);
    e->tensor_name = name;
    e->key = key;
    e->context = context;
    e->tensor = NULL;
    e->output = output;
    e->ready_event = ready_event;
    e->device = device;
    e->priority = priority;
    e->version = version;
    e->callback = callback;

    CHECK(e->output);
    e->keys.push_back(key);
    e->lens.push_back(e->output->size());

    BPS_LOG(TRACE) << "EnqueueTensorPull: " << e->tensor_name
                   << ", key=" << e->key
                   << ", size=" << e->output->size()
                   << ", device=" << device;
    BytePSGlobal::GetScheduledQueue(PULL)->addTask(e);
    return Status::OK();
}

Status EnqueueTensorBroadcast(std::shared_ptr<OpContext> context,
                        std::shared_ptr<Tensor> output,
                        std::shared_ptr<ReadyEvent> ready_event,
                        const std::string &name, ps::Key key,
                        const int device, const int priority, const int version,
                        StatusCallback callback) {
    std::shared_ptr<TensorTableEntry> e(new TensorTableEntry);
    e->tensor_name = name;
    e->key = key;
    e->context = context;
    e->tensor = NULL;
    e->output = output;
    e->ready_event = ready_event;
    e->device = device;
    e->priority = priority;
    e->version = version;
    e->callback = callback;

    CHECK(e->output);
    e->keys.push_back(key);
    e->lens.push_back(e->output->size());

    BPS_LOG(TRACE) << "EnqueueTensorBroadcast: " << e->tensor_name
                   << ", key=" << e->key
                   << ", size=" << e->output->size()
                   << ", device=" << device;
    BytePSGlobal::GetScheduledQueue(BROADCAST)->addTask(e);
    return Status::OK();
}

Status InitTensor(std::shared_ptr<OpContext> context,
                std::shared_ptr<Tensor> tensor,
                std::shared_ptr<ReadyEvent> ready_event,
                const std::string &name, const int device,
                StatusCallback callback) {
    
    // Only rank 0 pushes the initialization
    if (BytePSGlobal::GetRank() == 0) {

        // get metadata
        size_t size = tensor->size();
        const int dtype = tensor->dtype();

        // convert to ps keys
        ps::Key key = BytePSGlobal::GetKeyFromName(name);
        ps::SArray<ps::Key> keys(&key, 1, false);

        char* data = const_cast<char*> (static_cast<const char*> (tensor->data()));
        // false means not to delete data when SArray is deleted
        ps::SArray<char> vals(data, size, false);

        int len = size;
        ps::SArray<int> lens(&len, 1, false);

        int cmd = GetCommandType(RequestType::kDefaultPushPull, dtype);
        BytePSGlobal::GetPS()->Wait(BytePSGlobal::GetPS()->ZPush(
            keys, vals, lens, cmd));
    }

    ps::Postoffice::Get()->Barrier(0, ps::kWorkerGroup);

    BPS_LOG(TRACE) << "Init tensor: " << name
                   << ", key=" << BytePSGlobal::GetKeyFromName(name)
                   << ", size=" << tensor->size()
                   << ", device=" << device;
    callback(Status::OK());
    return Status::OK();
}

} // namespace common
} // namespace byteps
