./dist_worker.sh 1 1 0 0 0  python train_imagenet.py --network resnet --num-layers 50 --benchmark 1 --kv-store dist_sync --batch-size 128 --disp-batches 100 --num-examples 25600 --num-epochs 1 --gpus 0,1,2,3 --role worker
