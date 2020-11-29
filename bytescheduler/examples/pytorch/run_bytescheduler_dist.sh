export USE_BYTESCHEDULER=1
export BYTESCHEDULER_QUEUE_TYPE=0
# export BYTESCHEDULER_TUNING=1
export BYTESCHEDULER_PARTITION=8000000
export BYTESCHEDULER_CREDIT=8000000
export BYTESCHEDULER_CREDIT_TUNING=0
export BYTESCHEDULER_PARTITION_TUNING=0
 export BYTESCHEDULER_TIMELINE=timeline_bs.json
# export BYTESCHEDULER_DEBUG=1
export PS_VERBOSE=1

horovodrun -np 2 -H localhost:1,172.31.95.237:1 -p 2022 python /home/cluster/byteps/bytescheduler/examples/pytorch/pytorch_horovod_benchmark.py
