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
chmod 600 ~/byteps/bytescheduler-20201004.pem
chmod 600 ~/byteps/bytescheduler-0105.pem
id2translate=$(cat ~/.ssh/id_rsa.pub)

#ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.19.234 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.33.245 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.45.149 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.40.49 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.45.49 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.40.202 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.45.105 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.32.103 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.34.167 "echo $id2translate >>~/.ssh/authorized_keys"

cd ~/
# setup docker and connect to container
# mxnet ps ssh t4 myps
docker login -u rivendile -p zhyh19980824
docker pull rivendile/byteps-mxnet
nvidia-docker run -it --gpus all --ipc=host --name mlnet-analysis-byteps-mxnet --network host -v /home/ubuntu/byteps:/home/cluster/byteps --detach 3fe34daac76b
docker_container_id=$(docker ps -aqf "name=mlnet-analysis-byteps-mxnet")
docker cp $docker_container_id:/home/cluster/.ssh ~/mlnet_analysis_byteps_mxnet_ssh
ssh -i ~/mlnet_analysis_byteps_mxnet_ssh/id_rsa -p 2022 cluster@localhost
