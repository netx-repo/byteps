export USE_BYTESCHEDULER=1
export BYTESCHEDULER_QUEUE_TYPE=0
# export BYTESCHEDULER_TUNING=1
export BYTESCHEDULER_PARTITION=8000000
export BYTESCHEDULER_CREDIT=8000000
export BYTESCHEDULER_CREDIT_TUNING=0
export BYTESCHEDULER_PARTITION_TUNING=0
# export BYTESCHEDULER_TIMELINE=timeline_bs.json
# export BYTESCHEDULER_DEBUG=1
export PS_VERBOSE=1
export BYTESCHEDULER_ROOT_IP=localhost
export BYTESCHEDULER_ROOT_PORT=8000

horovodrun -np 2 -H localhost:1,35.171.164.27:1 python train_imagenet_horovod.py --network vgg --num-layers 16 --kv-store dist_sync_device --batch-size 32 --disp-batches 10 --num-epochs 1 --gpus 0 --benchmark 1 --num-examples 16352 #--data-train ~/data/data_train.rec --data-train-idx ~/data/data_train.idx --data-val ~/data/data_val.rec --data-val-idx ~/data/data_val.idx --data-nthreads 8
