export dmlc_num_server=2
export dmlc_num_worker=2
export dmlc_ps_root_uri='172.31.40.76'

export BYTESCHEDULER_DEBUG=1
export BYTESCHEDULER_TIMELINE=/home/cluster/byteps/bytescheduler/examples/mxnet-image-classification/timeline.json

# baseline
export use_bytescheduler=0
export bytescheduler_queue_type=0
export bytescheduler_partition=8000000
export bytescheduler_credit=160000000
export bytescheduler_credit_tuning=0
export bytescheduler_partition_tuning=0

# schedule
#export use_bytescheduler=1
#export bytescheduler_queue_type=0
#export bytescheduler_partition=480000000
#export bytescheduler_credit=480000000
#export bytescheduler_credit_tuning=0
#export bytescheduler_partition_tuning=0

# partition
#export use_bytescheduler=1
#export bytescheduler_queue_type=1
#export bytescheduler_partition=4096000
#export bytescheduler_credit=20000000
#export bytescheduler_credit_tuning=0
#export bytescheduler_partition_tuning=0

# bytescheduler
#export use_bytescheduler=1
#export bytescheduler_queue_type=0
#export bytescheduler_partition=4096000
#export bytescheduler_credit=20000000
#export bytescheduler_credit_tuning=0
#export bytescheduler_partition_tuning=0


export COMMAND='python train_imagenet.py --network resnet --num-layers 50 --kv-store dist_sync_device --batch-size 32 --disp-batches 10 --num-epochs 1 --gpus 0 --benchmark 1 --num-examples 10496'
#--data-train /home/cluster/data/data_train.rec --data-train-idx /home/cluster/data/data_train.idx --data-val /home/cluster/data/data_val.rec --data-val-idx /home/cluster/data/data_val.idx --data-nthreads 8

# scheduler
DMLC_ROLE='scheduler' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &

# server
ssh cluster@172.31.40.76 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
ssh cluster@172.31.32.101 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
#ssh cluster@172.31.69.146 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
#ssh cluster@172.31.76.130 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
#ssh cluster@172.31.69.106 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
#ssh cluster@172.31.74.151 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
#ssh cluster@172.31.79.14 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &
#ssh cluster@172.31.70.203 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='server' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND &" &

# worker
ssh cluster@172.31.40.76 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
ssh cluster@172.31.32.101 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
#ssh cluster@172.31.69.146 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
#ssh cluster@172.31.76.130 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
#ssh cluster@172.31.69.106 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
#ssh cluster@172.31.74.151 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
#ssh cluster@172.31.79.14 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
#ssh cluster@172.31.70.203 "cd /home/cluster/byteps/bytescheduler/examples/mxnet-image-classification;DMLC_ROLE='worker' DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker USE_BYTESCHEDULER=$use_bytescheduler BYTESCHEDULER_QUEUE_TYPE=$bytescheduler_queue_type BYTESCHEDULER_PARTITION=$bytescheduler_partition BYTESCHEDULER_CREDIT=$bytescheduler_credit DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 BYTESCHEDULER_CREDIT_TUNING=$bytescheduler_credit_tuning BYTESCHEDULER_PARTITION_TUNING=$bytescheduler_partition_tuning PS_SLICER=0 KVSTORE_MAP_KIND=0 KVSTORE_MAP_MODEL=1 $COMMAND >test.txt 2>&1 &" &
