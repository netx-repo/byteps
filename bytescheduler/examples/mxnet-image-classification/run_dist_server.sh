# dmlc_num_server, dmlc_num_worker, use_bytescheduler, bytescheduler_queue_type, kvstore_map_kind, kvstore_map_model, bytescheduler_partition
#./dist_server.sh 8 8 0 0 0 1 8000000 python train_imagenet.py --network vgg --num-layers 16 --benchmark 1 --kv-store dist_sync_device --batch-size 256 --disp-batches 10 --num-examples 130816 --num-epochs 1 --gpus 0,1,2,3,4,5,6,7 --role server
./dist_server.sh 1 1 0 0 0 1 8000000 python train_imagenet.py --network vgg --num-layers 16 --benchmark 1 --kv-store dist_sync_device --batch-size 32 --disp-batches 10 --num-examples 28416 --num-epochs 1 --gpus 0 --role server
