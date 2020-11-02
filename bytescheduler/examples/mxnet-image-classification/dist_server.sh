#!/bin/bash
# set -x
if [ $# -lt 3 ]; then
    echo "usage: $0 num_servers num_workers bin [args..]"
    exit -1;
fi

export USE_BYTESCHEDULER=0
export BYTESCHEDULER_QUEUE_TYPE=0
#export MXNET_CUDNN_AUTOTUNE_DEFAULT=0
# export BYTESCHEDULER_TUNING=1
# export BYTESCHEDULER_PARTITION=512000
# export BYTESCHEDULER_CREDIT=4096000
#export BYTESCHEDULER_TIMELINE=timeline.json
# export BYTESCHEDULER_DEBUG=1
export PS_VERBOSE=1

export DMLC_NUM_SERVER=$1
shift
export DMLC_NUM_WORKER=$1
shift
bin=$1
shift
arg="$@"

# start the scheduler
export DMLC_PS_ROOT_URI='172.31.82.93'
export DMLC_PS_ROOT_PORT=8000

# start servers
export DMLC_ROLE='server'
#for ((i=0; i<${DMLC_NUM_SERVER}; ++i)); do
#    export HEAPPROFILE=./S${i}
#    ${bin} ${arg} &
#done

#nvprof -o bs_server_profile.nvvp ${bin} ${arg} &
export MXNET_EXEC_BULK_EXEC_INFERENCE=0
export MXNET_EXEC_BULK_EXEC_TRAIN=0
export MXNET_PROFILER_AUTOSTART=1
${bin} ${arg} &

wait
