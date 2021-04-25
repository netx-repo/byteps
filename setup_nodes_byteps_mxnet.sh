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
chmod 600 ~/byteps/bytescheduler-0105.pem
id2translate=$(cat ~/.ssh/id_rsa.pub)

ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.85.99 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.33.207 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.34.181 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.38.43 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.41.18 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.44.99 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.42.65 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.42.113 "echo $id2translate >>~/.ssh/authorized_keys"
#ssh -i ~/byteps/bytescheduler-0105.pem ubuntu@172.31.36.234 "echo $id2translate >>~/.ssh/authorized_keys"

cd ~/
# setup docker and connect to container
# mxnet ps ssh t4 myps
docker pull rivendile/byteps-mxnet
nvidia-docker run -it --gpus all --ipc=host --shm-size=32768m --name mlnet-analysis-byteps-mxnet --network host -v /home/ubuntu/byteps:/home/cluster/byteps --detach 3fe34daac76b
docker_container_id=$(docker ps -aqf "name=mlnet-analysis-byteps-mxnet")
docker cp $docker_container_id:/home/cluster/.ssh ~/mlnet_analysis_byteps_mxnet_ssh
ssh -i ~/mlnet_analysis_byteps_mxnet_ssh/id_rsa -p 2022 cluster@localhost
