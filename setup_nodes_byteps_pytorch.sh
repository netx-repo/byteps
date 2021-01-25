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

ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.18.55 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.40.134 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.40.211 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.40.84 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.40.0 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.46.249 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.46.170 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-20201004.pem ubuntu@172.31.43.224 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.47.10 "echo $id2translate >>~/.ssh/authorized_keys"

cd ~/
# setup docker and connect to container
# mxnet ps ssh t4 myps
docker login -u rivendile -p zhyh19980824
docker pull rivendile/byteps-pytorch
nvidia-docker run -it --gpus all --ipc=host --name mlnet-analysis-byteps-pytorch --network host -v /home/ubuntu/byteps:/home/cluster/byteps --detach 535ec11ae861
docker_container_id=$(docker ps -aqf "name=mlnet-analysis-byteps-pytorch")
docker cp $docker_container_id:/home/cluster/.ssh ~/mlnet_analysis_byteps_pytorch_ssh
ssh -i ~/mlnet_analysis_byteps_pytorch_ssh/id_rsa -p 2022 cluster@localhost
