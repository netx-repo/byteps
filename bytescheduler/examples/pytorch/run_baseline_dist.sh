export USE_BYTESCHEDULER=0
#export BYTESCHEDULER_QUEUE_TYPE=0
# export BYTESCHEDULER_TUNING=1
export BYTESCHEDULER_PARTITION=8000000
export BYTESCHEDULER_CREDIT=8000000
export BYTESCHEDULER_CREDIT_TUNING=0
export BYTESCHEDULER_PARTITION_TUNING=0
 export BYTESCHEDULER_TIMELINE=timeline_baseline.json
# export BYTESCHEDULER_DEBUG=1
export PS_VERBOSE=1

horovodrun -np 2 -H localhost:1,3.236.249.44:1 -p 2022 python pytorch_horovod_benchmark.py --model vgg16 --num-batches-per-iter 100 --num-iters 5 --train-dir /home/cluster/data/imagenet
