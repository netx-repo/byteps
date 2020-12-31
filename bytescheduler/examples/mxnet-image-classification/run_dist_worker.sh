# dmlc_num_server, dmlc_num_worker, use_bytescheduler, bytescheduler_queue_type, kvstore_map_kind, kvstore_map_model, bytescheduler_partition
#./dist_worker.sh 8 8 0 0 0 1 8000000 python train_imagenet.py --network vgg --num-layers 16 --benchmark 1 --kv-store dist_sync_device --batch-size 256 --disp-batches 10 --num-examples 130816 --num-epochs 1 --gpus 0,1,2,3,4,5,6,7 --role worker
./dist_worker.sh 1 1 1 0 0 0 8000000 python train_imagenet.py --network resnet --num-layers 50 --kv-store dist_sync_device --batch-size 32 --disp-batches 10 --num-epochs 1 --gpus 0 --benchmark 0 --data-train /home/cluster/data/data_train.rec --data-train-idx /home/cluster/data/data_train.idx --data-val /home/cluster/data/data_val.rec --data-val-idx /home/cluster/data/data_val.idx --data-nthreads 8
