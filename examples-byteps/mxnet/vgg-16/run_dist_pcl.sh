export dmlc_num_server=$(sed -n '$=' /userhome/nodelist.txt)
export dmlc_num_worker=$(sed -n '$=' /userhome/nodelist.txt)
export nvidia_visible_devices=0,1,2,3,4,5,6,7
export distributed_framework=byteps

#schedule
export byteps_server_enable_schedule=1
export byteps_scheduling_credit=4
#no-schedule
#export byteps_server_enable_schedule=0
#export byteps_scheduling_credit=0
# partition
export byteps_partition_bytes=4096000
#no-partition
#export byteps_partition_bytes=480000000

export dmlc_ps_root_uri=$(head -n 1 /userhome/nodelist.txt)
export byteps_trace_on=1
export byteps_trace_dir=/home/cluster/byteps/examples-byteps/mxnet/vgg-16/vgg16-100-3
echo $dmlc_ps_root_uri
echo $distributed_framework
export COMMAND='python3 /home/cluster/byteps/examples-byteps/mxnet/vgg-16/train_imagenet.py --network vgg --num-layers 16 --batch-size 32 --benchmark 1 --num-examples 3552 --num-epochs 1 --disp-batches 10'

# scheduler
echo "start scheduler"
BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_ROLE=scheduler DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000  bpslaunch &

# server
echo "start server"
while read -u 16 host
do
    echo $host; ssh cluster@$host "BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_ROLE=server DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000  bpslaunch &" &
done 16</userhome/nodelist.txt

# worker
echo "start server"
while read -u 16 host
do
    echo $host; ssh cluster@$host "BYTEPS_TRACE_ON=$byteps_trace_on BYTEPS_TRACE_END_STEP=20 BYTEPS_TRACE_START_STEP=10 BYTEPS_TRACE_DIR=$byteps_trace_dir DMLC_WORKER_ID=0 DMLC_ROLE=worker DMLC_NUM_SERVER=$dmlc_num_server DMLC_NUM_WORKER=$dmlc_num_worker NVIDIA_VISIBLE_DEVICES=$nvidia_visible_devices DISTRIBUTED_FRAMEWORK=$distributed_framework BYTEPS_SERVER_ENABLE_SCHEDULE=$byteps_server_enable_schedule BYTEPS_SCHEDULING_CREDIT=$byteps_scheduling_credit BYTEPS_PARTITION_BYTES=$byteps_partition_bytes DMLC_PS_ROOT_URI=$dmlc_ps_root_uri DMLC_PS_ROOT_PORT=8000 bpslaunch $COMMAND >/home/cluster/byteps/examples-byteps/mxnet/vgg-16/test.txt 2>&1 &" &
done 16</userhome/nodelist.txt
