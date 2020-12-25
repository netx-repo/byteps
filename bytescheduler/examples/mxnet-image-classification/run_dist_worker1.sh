# dmlc_num_server, dmlc_num_worker, ps_slicer, use_bytescheduler, bytescheduler_queue_type, kvstore_map_kind, kvstore_map_model
./dist_worker.sh 2 16 0 0 0 1 0 python train_imagenet.py --network resnet --num-layers 50 --benchmark 1 --kv-store dist_sync --batch-size 32 --disp-batches 100 --num-examples 6720 --num-epochs 1 --gpus 1 --role worker
