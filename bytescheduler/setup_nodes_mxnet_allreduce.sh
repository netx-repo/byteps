#!/bin/bash

# setup SSH
cd ~/.ssh
touch config
echo "Host *" >>~/.ssh/config
echo "    ForwardAgent yes" >>~/.ssh/config
echo "Host *" >>~/.ssh/config
echo "    StrictHostKeyChecking no" >>~/.ssh/config
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/config
chmod 600 ~/byteps/bytescheduler/bytescheduler-0105.pem
id2translate=$(cat ~/.ssh/id_rsa.pub)
ssh -i ~/byteps/bytescheduler/bytescheduler-0105.pem ubuntu@172.31.73.161 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler/bytescheduler-0105.pem ubuntu@172.31.71.216 "echo $id2translate >>~/.ssh/authorized_keys"

cd ~/
# setup docker and connect to container
docker pull zycccc/horovod-mxnet-aws
nvidia-docker run -it --gpus all --ipc=host --name mlnet-analysis-mxnet-horovod --network host -v /home/ubuntu/byteps:/home/cluster/byteps --detach zycccc/horovod-mxnet-aws
docker_container_id=$(docker ps -aqf "name=mlnet-analysis-mxnet-horovod")
docker cp $docker_container_id:/home/cluster/.ssh ~/mlnet_analysis_mxnet_horovod_ssh
ssh -i ~/mlnet_analysis_mxnet_horovod_ssh/id_rsa -p 2022 cluster@localhost
