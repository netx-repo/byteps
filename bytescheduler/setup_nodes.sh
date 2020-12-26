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
ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.94.121 "echo $id2translate >>~/.ssh/authorized_keys"

# setup docker and connect to container
# mxnet ps t4 
docker login -u rivendile -p zhyh19980824
docker pull rivendile/bsc-mxnet-ps-ssh-t4
nvidia-docker run -it --gpus all --ipc=host --name mlnet-analysis --network host -v /home/ubuntu/byteps:/home/cluster/byteps --detach 4f99085b602b
docker_container_id=$(docker ps -aqf "name=mlnet-analysis")
docker cp $docker_container_id:/home/cluster/.ssh ~/mxnet_ps_ssh_t4
ssh -i ~/mxnet_ps_ssh_t4/id_rsa -p 2022 cluster@localhost
cd ~/byteps/bytescheduler/examples/mxnet-image-classification
git config user.email "908636821@qq.com"
git config user.name "rivendile"
