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
chmod 600 ~/byteps/bytescheduler/bytescheduler-0105.pem
id2translate=$(cat ~/.ssh/id_rsa.pub)
ssh -i ~/byteps/bytescheduler/bytescheduler-0105.pem ubuntu@172.31.15.181 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-0105.pem ubuntu@172.31.65.113 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-0105.pem ubuntu@172.31.69.146 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-0105.pem ubuntu@172.31.76.130 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-0105.pem ubuntu@172.31.69.106 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-0105.pem ubuntu@172.31.74.151 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-0105.pem ubuntu@172.31.79.14 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-0105.pem ubuntu@172.31.70.203 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.90.224 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.94.48 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.82.0 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.85.90 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.83.247 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.86.179 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.83.146 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler/bytescheduler-20201004.pem ubuntu@172.31.88.98 "echo $id2translate >>~/.ssh/authorized_keys"

cd ~/
# setup docker and connect to container
# mxnet ps ssh t4 myps
docker login -u rivendile -p zhyh19980824
docker pull rivendile/bsc-mxnet-ps-ssh
nvidia-docker run -it --gpus all --ipc=host --name mlnet-analysis --network host -v /home/ubuntu/byteps:/home/cluster/byteps --detach 8565e522a91c
docker_container_id=$(docker ps -aqf "name=mlnet-analysis")
docker cp $docker_container_id:/home/cluster/.ssh ~/mlnet_analysis_ssh
ssh -i ~/mlnet_analysis_ssh/id_rsa -p 2022 cluster@localhost
