# ./local.sh 1 1 python -m trace --ignore-dir=/usr/lib/python2.7 --trace train_imagenet.py --network vgg --num-layers 16 --benchmark 1 --kv-store dist_sync --batch-size 2 --disp-batches 10 --num-examples 22 --num-epochs 1 --gpus 0 >trace_bytescheduler_test.txt
# dmlc_num_server, dmlc_num_worker, ps_slicer, use_bytescheduler, bytescheduler_queue_type, kvstore_map_kind, kvstore_map_model(0 resnet50; 1 vgg16), bytescheduler_partition
 ./local.sh 1 1 0 0 0 0 1 8000000 python train_imagenet.py --network vgg --num-layers 16 --kv-store dist_sync_device --batch-size 32 --disp-batches 10 --num-epochs 1 --gpus 0 --benchmark 0 --data-train ~/data/data_train.rec --data-train-idx ~/data/data_train.idx --data-val ~/data/data_val.rec --data-val-idx ~/data/data_val.idx --data-nthreads 8 #--num-examples 3520
