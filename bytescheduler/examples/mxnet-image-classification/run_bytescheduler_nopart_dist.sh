export USE_BYTESCHEDULER=1
export BYTESCHEDULER_QUEUE_TYPE=2
# export BYTESCHEDULER_TUNING=1
export BYTESCHEDULER_PARTITION=160000000
export BYTESCHEDULER_CREDIT=8000000
export BYTESCHEDULER_CREDIT_TUNING=0
export BYTESCHEDULER_PARTITION_TUNING=0
# export BYTESCHEDULER_TIMELINE=timeline_bs_nopart.json
# export BYTESCHEDULER_DEBUG=1
export PS_VERBOSE=1

horovodrun -np 8 -H localhost:4,3.93.217.10:4 -p 2022  python train_imagenet_horovod.py --network vgg --num-layers 16 --kv-store dist_sync_device --batch-size 32 --disp-batches 10 --num-epochs 1 --gpus 0,1,2,3 --benchmark 0 --data-train ~/data/data_train.rec --data-train-idx ~/data/data_train.idx --data-val ~/data/data_val.rec --data-val-idx ~/data/data_val.idx --data-nthreads 8
