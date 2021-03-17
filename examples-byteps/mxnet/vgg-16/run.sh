#!/bin/bash

export DISTRIBUTED_FRAMEWORK=byteps
export NVIDIA_VISIBLE_DEVICES=0  # gpus list
export DMLC_WORKER_ID=0 # your worker id
export DMLC_NUM_WORKER=1 # one worker
export DMLC_ROLE=worker

# the following value does not matter for non-distributed jobs
export DMLC_NUM_SERVER=1
export DMLC_PS_ROOT_URI=172.31.93.148
export DMLC_PS_ROOT_PORT=1234
export BYTEPS_SERVER_ENABLE_SCHEDULE=1
export BYTEPS_SCHEDULING_CREDIT=8000000
export BYTEPS_PARTITION_BYTES=4096000
# you can also test other networks (e.g., ResNet) with different number of layers
bpslaunch python3 train_imagenet.py --network vgg --num-layers 16 --batch-size 32 --benchmark 1 --num-examples 3232 --num-epochs 1 --disp-batches 10 $@
