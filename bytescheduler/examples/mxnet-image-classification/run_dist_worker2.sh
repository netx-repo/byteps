# dmlc_num_server, dmlc_num_worker, ps_slicer, use_bytescheduler, bytescheduler_queue_type, kvstore_map_kind, kvstore_map_model
./dist_worker.sh 2 16 0 0 0 1 1 python train_imagenet.py --network vgg --num-layers 16 --benchmark 1 --kv-store dist_sync --batch-size 32 --disp-batches 100 --num-examples 6720 --num-epochs 1 --gpus 2 --role worker
