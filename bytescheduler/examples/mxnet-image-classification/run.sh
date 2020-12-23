# ./local.sh 1 1 python -m trace --ignore-dir=/usr/lib/python2.7 --trace train_imagenet.py --network vgg --num-layers 16 --benchmark 1 --kv-store dist_sync --batch-size 2 --disp-batches 10 --num-examples 22 --num-epochs 1 --gpus 0 >trace_bytescheduler_test.txt
# dmlc_num_server, dmlc_num_worker, ps_slicer, use_bytescheduler, bytescheduler_queue_type, kvstore_map_kind, kvstore_map_model
 ./local.sh 1 1 0 0 0 0 0 python train_imagenet.py --network resnet --num-layers 50 --benchmark 1 --kv-store dist_sync --batch-size 2 --disp-batches 1 --num-examples 6 --num-epochs 1 --gpus 0
