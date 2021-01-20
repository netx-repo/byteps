#!/bin/bash
git clone https://github.com/Rivendile/byteps.git
cd byteps
git config  credential.helper store
git submodule init
git submodule update

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
chmod 600 ~/byteps/bytescheduler-20201004.pem
chmod 600 ~/byteps/bytescheduler-0105.pem
id2translate=$(cat ~/.ssh/id_rsa.pub)
ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.92.249 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.86.205 "echo $id2translate >>~/.ssh/authorized_keys"

cd ~/
# setup docker and connect to container
# mxnet ps ssh t4 myps
docker login -u zycccc -p 314159dos
docker pull zycccc/env_with_data
nvidia-docker run -it --gpus all --ipc=host --name tf --network host -v /home/ubuntu/byteps:/home/cluster/byteps --detach 192869058071
docker_container_id=$(docker ps -aqf "name=tf")
docker cp $docker_container_id:/home/cluster/.ssh ~/mlnet_analysis_ssh
ssh -i ~/mlnet_analysis_ssh/id_rsa -p 2022 cluster@localhost
