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
chmod 600 ~/byteps/bytescheduler-0105.pem
id2translate=$(cat ~/.ssh/id_rsa.pub)
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.44.105 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.45.34 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.41.158 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.40.162 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.47.159 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.47.199 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.35.39 "echo $id2translate >>~/.ssh/authorized_keys"
ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.47.64 "echo $id2translate >>~/.ssh/authorized_keys"

cd ~/
# setup docker and connect to container
docker pull zycccc/byteps-tf
nvidia-docker run -it --gpus all --ipc=host --name mlnet-analysis-byteps-tf --network host -v /home/ubuntu/byteps:/home/cluster/byteps --detach zycccc/byteps-tf
docker_container_id=$(docker ps -aqf "name=mlnet-analysis-byteps-tf")
docker cp $docker_container_id:/home/cluster/.ssh ~/mlnet_analysis_ssh
ssh -i ~/mlnet_analysis_ssh/id_rsa -p 2022 cluster@localhost
