# dmlc_num_server, dmlc_num_worker, ps_slicer, use_bytescheduler, bytescheduler_queue_type, kvstore_map_kind, kvstore_map_model, bytescheduler_partition
./dist_server.sh 1 1 0 0 0 0 0 8000000 python train_imagenet.py --network resnet --num-layers 50 --benchmark 1 --kv-store dist_sync --batch-size 256 --disp-batches 10 --num-examples 130816 --num-epochs 1 --gpus 0,1,2,3,4,5,6,7 --role server
