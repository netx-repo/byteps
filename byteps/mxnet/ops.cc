// Copyright 2019 ByteDance Inc. or its affiliates. All Rights Reserved.
// Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

#include <atomic>

#include "adapter.h"
#include "cuda_util.h"
#include "ops.h"
#include "ready_event.h"
#include "tensor_util.h"

namespace byteps {
namespace mxnet {

namespace {

std::atomic_int op_count;

std::string GetOpName(std::string prefix, char* name) {
  if (name != nullptr) {
    return prefix + "." + std::string(name);
  }

  op_count.fetch_add(1);
  return prefix + ".noname." + std::to_string(op_count);
}
} // namespace

inline void InvokeCompleteCallback(Callback on_complete, const Status& status) {
  if (status.ok()) {
    on_complete();
  } else {
    auto error = dmlc::Error(status.reason());
    on_complete(&error);
  }
}

void DoPush(NDArray* input, const std::string& name, int version, int priority,
                 Callback on_complete) {
  ThrowIfError(common::CheckInitialized());

  auto device = TensorUtil::GetDevice(input);
  auto byteps_input = std::make_shared<MXTensor<NDArray>>(input);
  auto byteps_context = std::make_shared<MXOpContext<NDArray>>(device, input);
  auto key = BytePSGlobal::GetKeyFromName(name);

  auto enqueue_result =
      EnqueueTensorPush(byteps_context, byteps_input, nullptr,
                             name, key, device, priority, version,
                             [on_complete](const Status& status) {
                               InvokeCompleteCallback(on_complete, status);
                             });
  ThrowIfError(enqueue_result);
}

void DoPull(NDArray* output, const std::string& name, int version, int priority,
                 Callback on_complete) {
  ThrowIfError(common::CheckInitialized());

  auto device = TensorUtil::GetDevice(output);
  auto byteps_output = std::make_shared<MXTensor<NDArray>>(output);
  auto byteps_context = std::make_shared<MXOpContext<NDArray>>(device, output);
  auto key = BytePSGlobal::GetKeyFromName(name);

  auto enqueue_result =
      EnqueueTensorPull(byteps_context, byteps_output, nullptr,
                             name, key, device, priority, version,
                             [on_complete](const Status& status) {
                               InvokeCompleteCallback(on_complete, status);
                             });
  ThrowIfError(enqueue_result);
}

void DoInit(NDArray* input, const std::string& name, Callback on_complete) {
    ThrowIfError(common::CheckInitialized());

    auto device = TensorUtil::GetDevice(input);
    auto byteps_input = std::make_shared<MXTensor<NDArray>>(input);
    auto byteps_context = std::make_shared<MXOpContext<NDArray>>(device, input);

    auto init_result = InitTensor(byteps_context, byteps_input, nullptr,
                                  name, device,
                                  [on_complete](const Status& status) {
                                    InvokeCompleteCallback(on_complete, status);
                                  });

    ThrowIfError(init_result);
}

void DoUpdate(NDArray* input, const std::string& name, int version, int priority,
                 Callback on_complete) {
  ThrowIfError(common::CheckInitialized());

  auto device = TensorUtil::GetDevice(input);
  auto byteps_input = std::make_shared<MXTensor<NDArray>>(input);
  auto byteps_context = std::make_shared<MXOpContext<NDArray>>(device, input);
  auto key = BytePSGlobal::GetKeyFromName(name);

  auto enqueue_result =
      EnqueueTensorReduce(byteps_context, byteps_input, nullptr,
                             name, key, device, priority, version,
                             [on_complete](const Status& status) {
                               InvokeCompleteCallback(on_complete, status);
                             });
  ThrowIfError(enqueue_result);
}

extern "C" int byteps_mxnet_push_pull_async(NDArray* tensor,
                                            char* name, int version, int priority) {
    MX_API_BEGIN();

    // TODO: replace "byteps" with job ID
    std::string tensor_name = GetOpName("byteps", name);
    // check if we need to init the tensor
    if (BytePSGlobal::EncodeNameToKey(tensor_name)) {
        // we need to init this tensor
        auto init_async_fn = [tensor, tensor_name](RunContext rctx,
                                      Callback on_complete) mutable {
            DoInit(tensor, tensor_name, on_complete);
        };

        Engine::Get()->PushAsync(init_async_fn, tensor->ctx(),
                                {}, {tensor->var()},
                                FnProperty::kNormal, 0, "BytePSInit");
    }

    auto update_async_fn = [tensor, tensor_name, version, priority](RunContext rctx,
                                      Callback on_complete) mutable {
        DoUpdate(tensor, tensor_name, version, priority, on_complete);
    };

    Engine::Get()->PushAsync(update_async_fn, tensor->ctx(),
                            {}, {tensor->var()},
                            FnProperty::kNormal, 0, "BytePSUpdate");

    MX_API_END();
}

} // namespace mxnet
} // namespace byteps
