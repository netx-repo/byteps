#!/bin/bash

# setup SSH
sudo apt install -y nload iperf bridge-utils
cd ~/.ssh
touch config
echo "Host *" >>~/.ssh/config
echo "    ForwardAgent yes" >>~/.ssh/config
echo "Host *" >>~/.ssh/config
echo "    StrictHostKeyChecking no" >>~/.ssh/config
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/config
chmod 600 ~/byteps/bytescheduler-20201004.pem
chmod 600 ~/byteps/bytescheduler-0105.pem
id2translate=$(cat ~/.ssh/id_rsa.pub)

ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.29.222 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.22.63 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.31.168 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.23.189 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.27.199 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.17.87 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.17.64 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.24.80 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.36.234 "echo $id2translate >>~/.ssh/authorized_keys"

cd ~/
# setup docker and connect to container
# mxnet ps ssh t4 myps
docker login -u rivendile -p zhyh19980824
docker pull rivendile/byteps-mxnet
nvidia-docker run -it --gpus all --ipc=host --name mlnet-analysis-byteps-mxnet --network host -v /home/ubuntu/byteps:/home/cluster/byteps --detach 3fe34daac76b
docker_container_id=$(docker ps -aqf "name=mlnet-analysis-byteps-mxnet")
docker cp $docker_container_id:/home/cluster/.ssh ~/mlnet_analysis_byteps_mxnet_ssh
ssh -i ~/mlnet_analysis_byteps_mxnet_ssh/id_rsa -p 2022 cluster@localhost
