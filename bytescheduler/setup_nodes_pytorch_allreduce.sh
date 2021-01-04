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
chmod 600 ~/byteps/bytescheduler/bytescheduler-20201004.pem
id2translate=$(cat ~/.ssh/id_rsa.pub)
ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.91.11 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.92.40 "echo $id2translate >>~/.ssh/authorized_keys"

cd ~/
# setup docker and connect to container
# mxnet ps ssh t4 myps
docker login -u rivendile -p zhyh19980824
docker pull rivendile/bsc-pytorch-horovod-ssh
nvidia-docker run -it --gpus all --ipc=host --name mlnet-pytorch-allreduce --network host -v /home/ubuntu/byteps:/home/cluster/byteps --detach 91d17623757d
docker_container_id=$(docker ps -aqf "name=mlnet-pytorch-allreduce")
docker cp $docker_container_id:/home/cluster/.ssh ~/mlnet_pytorch_allreduce_ssh
ssh -i ~/mlnet_pytorch_allreduce_ssh/id_rsa -p 2022 cluster@localhost
