#!/bin/bash

# setup SSH
echo "Host *" >>~/.ssh/config
echo "    ForwardAgent yes" >>~/.ssh/config
echo "Host *" >>.ssh/config
echo "    StrictHostKeyChecking no" >>~/.ssh/config
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/config
chmod 600 ~/byteps/bytescheduler/bytescheduler-20201004.pem
id2translate=$(cat ~/.ssh/id_rsa.pub)
ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.26.226 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.27.232 "echo $id2translate >>~/.ssh/authorized_keys"

# setup docker and connect to container
# mxnet ps t4 
docker login -u rivendile -p zhyh19980824
docker pull rivendile/bsc-mxnet-ps-ssh
nvidia-docker run -it --gpus all --ipc=host --name mlnet-analysis --network host -v /home/ubuntu/byteps:/home/cluster/byteps --detach bd1b3ec517f2
docker_container_id=$(docker ps -aqf "name=mlnet-analysis")
docker cp $docker_container_id:/home/cluster/.ssh ~/mxnet_ps_ssh
ssh -i ~/mxnet_ps_ssh/id_rsa -p 2022 cluster@localhost
