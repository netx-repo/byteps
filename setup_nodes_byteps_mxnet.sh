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
chmod 600 ~/byteps/mlnet.pem
id2translate=$(cat ~/.ssh/id_rsa.pub)

ssh -i ~/byteps/mlnet.pem ubuntu@172.31.26.225 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/mlnet.pem ubuntu@172.31.16.112 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/mlnet.pem ubuntu@172.31.23.109 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/mlnet.pem ubuntu@172.31.26.11 "echo $id2translate >>~/.ssh/authorized_keys"

cd ~/
# setup docker and connect to container
# mxnet ps ssh t4 myps
docker pull zycccc/ucx
nvidia-docker run -it --gpus all --ipc=host --name mlnet-analysis-byteps-mxnet --network host -v /home/ubuntu/byteps:/home/cluster/byteps --detach zycccc/ucx
docker_container_id=$(docker ps -aqf "name=mlnet-analysis-byteps-mxnet")
docker cp $docker_container_id:/home/cluster/.ssh ~/mlnet_analysis_byteps_mxnet_ssh
ssh -i ~/mlnet_analysis_byteps_mxnet_ssh/id_rsa -p 2022 cluster@localhost
