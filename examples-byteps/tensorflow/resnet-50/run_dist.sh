export dmlc_num_server=8
export dmlc_num_worker=8
export nvidia_visible_devices=0,1,2,3,4,5,6,7
export distributed_framework=byteps

#schedule
#export byteps_server_enable_schedule=1
#export byteps_scheduling_credit=4
#no-schedule
export byteps_server_enable_schedule=0
export byteps_scheduling_credit=0
# partition
#export byteps_partition_bytes=4096000
#no-partition
export byteps_partition_bytes=480000000

export dmlc_ps_root_uri=172.31.65.36
export byteps_trace_on=0
export byteps_trace_dir=/home/cluster/byteps/examples-byteps/tensorflow/resnet-50
export COMMAND='python3 benchmark.py --model VGG16 --num-iters 20'

# scheduler
BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_ROLE=scheduler DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000  bpslaunch &
#

## server
ssh cluster@172.31.65.36 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_ROLE=server DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000  bpslaunch &" &
ssh cluster@172.31.64.215 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_ROLE=server DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000  bpslaunch &" &
#ssh cluster@172.31.17.1 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_ROLE=server DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000  bpslaunch &" &
#ssh cluster@172.31.22.68 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_ROLE=server DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000  bpslaunch &" &
#ssh cluster@172.31.17.117 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_ROLE=server DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000  bpslaunch &" &
#ssh cluster@172.31.25.93 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_ROLE=server DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000  bpslaunch &" &
#ssh cluster@172.31.30.219 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_ROLE=server DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000  bpslaunch &" &
#ssh cluster@172.31.21.79 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_ROLE=server DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000  bpslaunch &" &



# worker
ssh cluster@172.31.65.36 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_WORKER_ID=0 DMLC_ROLE=worker DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 bpslaunch $COMMAND >/home/cluster/byteps/examples-byteps/tensorflow/resnet-50/test.txt 2>&1 &" &
ssh cluster@172.31.64.215 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_WORKER_ID=1 DMLC_ROLE=worker DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 bpslaunch $COMMAND &" &
#ssh cluster@172.31.17.1 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_WORKER_ID=2 DMLC_ROLE=worker DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 bpslaunch $COMMAND &" &
#ssh cluster@172.31.22.68 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_WORKER_ID=3 DMLC_ROLE=worker DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 bpslaunch $COMMAND &" &
#ssh cluster@172.31.17.117 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_WORKER_ID=4 DMLC_ROLE=worker DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 bpslaunch $COMMAND &" &
#ssh cluster@172.31.25.93 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_WORKER_ID=5 DMLC_ROLE=worker DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 bpslaunch $COMMAND &" &
#ssh cluster@172.31.30.219 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_WORKER_ID=6 DMLC_ROLE=worker DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 bpslaunch $COMMAND &" &
#ssh cluster@172.31.21.79 "cd $byteps_trace_dir;BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_WORKER_ID=7 DMLC_ROLE=worker DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 bpslaunch $COMMAND &" &
