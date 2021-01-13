export dmlc_num_server=4
export dmlc_num_worker=4
export use_bytescheduler=0
export bytescheduler_queue_type=0
export bytescheduler_partition=8000000
export dmlc_ps_root_uri='172.31.20.163'
export COMMAND='python train_imagenet.py --network vgg --num-layers 16 --kv-store dist_sync_device --batch-size 256 --disp-batches 10 --num-epochs 1 --gpus 0,1,2,3,4,5,6,7 --benchmark 1 --num-examples 28416'
#--data-train /home/cluster/data/data_train.rec --data-train-idx /home/cluster/data/data_train.idx --data-val /home/cluster/data/data_val.rec --data-val-idx /home/cluster/data/data_val.idx --data-nthreads 8

# scheduler
DMLC_ROLE='scheduler' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &

# server
ssh cluster@172.31.20.163 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
ssh cluster@172.31.31.58 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
ssh cluster@172.31.19.77 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
ssh cluster@172.31.21.62 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
#ssh cluster@172.31.89.77 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
#ssh cluster@172.31.89.77 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
#ssh cluster@172.31.89.77 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
#ssh cluster@172.31.89.77 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &

# worker
ssh cluster@172.31.23.78 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
ssh cluster@172.31.24.191 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
ssh cluster@172.31.28.63 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
ssh cluster@172.31.18.47 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
#ssh cluster@172.31.89.77 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
#ssh cluster@172.31.89.77 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
#ssh cluster@172.31.89.77 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
#ssh cluster@172.31.89.77 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=0 BYTESCHEDULER_PARTITION_TUNING=0 PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
