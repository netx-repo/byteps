# How Useful is Communication Scheduling for Distributed Training?

## Introduction
This is the repository of paper "How Useful is Communication Scheduling for Distributed Training?".  
The code is forked from BytePS.  
As for PS and all-reduce, please use the code in branch bytescheduler. Please refer to the readme in bytescheduler of branch bytescheduler for detailed usage.  
As for BytePS, please use the code in branch master. Please refer to xxx for detailed usage.  

## Content
Testing scripts to repoduce the results in out paper.

## Environment requirement
We have used EC2 Image: Deep Learning Base AMI (Ubuntu 18.04) Version 32.0 ami-0404ddec9491a5a31 with CUDA 10.0  
Belows are prebuilt docker images with BytePS/Bytescheduler and MxNet/Pytorch/TensorFlow(TF environment needs to add some operators...).  
* [BytePS MxNet Bert](https://github.com/netx-repo/byteps/blob/master/examples-byteps/mxnet/bert-large/run_dist.sh)  
* [BytePS PyTorch](https://github.com/netx-repo/byteps/blob/master/examples-byteps/pytorch/gpt-2/pytorch_gpt2.sh)  
* [PS MxNet Bert](https://github.com/ZYCCC927/examples/blob/master/mxnet/bert-large/run_bert.sh)  
* [PS MxNet Python3 version (for Bert)](https://github.com/ZYCCC927/examples/blob/master/mxnet/bert-large/run_bert.sh)  
* [All-Reduce MxNet](https://github.com/ZYCCC927/examples/blob/master/mxnet/bert-large/run_bert.sh)  
* [All-Reduce PyTorch](https://github.com/ZYCCC927/examples/blob/master/mxnet/bert-large/run_bert.sh)  
  (Docker images needs to be exposed)

## How to reproduce the results
Make sure that each machine can be connected from any other machines.
You can edit the enviorment varible to modify your experiment content. We have provided our sample settings in each script file.

* [PS MxNet VGG16 and ResNet50](https://github.com/netx-repo/byteps/blob/bytescheduler/bytescheduler/examples/mxnet-image-classification/run_dist.sh)  
* [PS MxNet Bert](https://github.com/ZYCCC927/examples/blob/master/mxnet/bert-large/run_bert.sh)  
* [BytePS MxNet VGG16 and ResNet50](https://github.com/netx-repo/byteps/blob/master/examples-byteps/mxnet/vgg-16/run_dist.sh)  
* [BytePS MxNet Bert](https://github.com/netx-repo/byteps/blob/master/examples-byteps/mxnet/bert-large/run_dist.sh)  
  
* [BytePS PyTorch VGG16 and ResNet50](https://github.com/netx-repo/byteps/blob/master/examples-byteps/pytorch/run_dist.sh)  
* [BytePS PyTorch GPT-2](https://github.com/netx-repo/byteps/blob/master/examples-byteps/pytorch/gpt-2/pytorch_gpt2.sh)  


* [All-Reduce MxNet VGG16](https://github.com/ZYCCC927/examples/blob/master/mxnet/bert-large/run_bert.sh)  
* [All-Reduce PyTorch VGG16/ResNet50](https://github.com/ZYCCC927/examples/blob/master/mxnet/bert-large/run_bert.sh)  

* PS TensorFlow VGG16  

* All-Reduce TensorFlow VGG16  

* All-Reduce PyTorch GPT2  




## Contact
For any questions, please contact `zhaoyh98 at pku dot edu dot cn`, 
