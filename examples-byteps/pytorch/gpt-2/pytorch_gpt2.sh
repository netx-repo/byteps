git clone https://github.com/Rivendile/byteps.git
cd byteps
git config  credential.helper store
git submodule init
git submodule update

wget https://s3.amazonaws.com/research.metamind.io/wikitext/wikitext-2-raw-v1.zip
unzip wikitext-2-raw-v1.zip && mv wikitext-2-raw ~/byteps/examples/pytorch/gpt-2 && rm wikitext-2-raw-v1.zip

bash setup_nodes_byteps_pytorch.sh

cd ~/byteps/examples/pytorch/gpt-2

sudo pip3 install wheel scipy Cython
cluster
wget https://files.pythonhosted.org/packages/14/67/e42bd1181472c95c8cda79305df848264f2a7f62740995a46945d9797b67/sentencepiece-0.1.95-cp36-cp36m-manylinux2014_x86_64.whl
mv sentencepiece-0.1.95-cp36-cp36m-manylinux2014_x86_64.whl sentencepiece-0.1.95-cp36-cp36m-linux_x86_64.whl
sudo pip3 install sentencepiece-0.1.95-cp36-cp36m-linux_x86_64.whl

export ROOT_DIR=${ROOT_DIR:-/home/cluster/byteps/examples/pytorch/gpt-2}
export TRAIN_FILE=${TRAIN_FILE:-$ROOT_DIR/wikitext-2-raw/wiki.train.raw}
export TEST_FILE=${TRAIN_FILE:-$ROOT_DIR/wikitext-2-raw/wiki.test.raw}
export DISTRIBUTED_FRAMEWORK=byteps

cd /home/cluster/byteps/examples/pytorch/gpt-2/gpt-2
sudo pip3 install .
sudo pip3 install -r ./examples/requirements.txt

sudo su root
export ROOT_DIR=${ROOT_DIR:-/home/cluster/byteps/examples/pytorch/gpt-2}
export TRAIN_FILE=${TRAIN_FILE:-$ROOT_DIR/wikitext-2-raw/wiki.train.raw}
export TEST_FILE=${TRAIN_FILE:-$ROOT_DIR/wikitext-2-raw/wiki.test.raw}
export DISTRIBUTED_FRAMEWORK=byteps
export NVIDIA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7,8

# for the first run, you can do a dryrun to
# prepare/download necessary configurations and models
# in order to avoid multi-write conflicts 
cd /home/cluster/byteps/examples/pytorch/gpt-2/gpt-2/examples
python3 -m torch.distributed.launch --nproc_per_node 8 run_lm_finetuning.py \
    --output_dir=output  \
    --model_type=gpt2   \
    --model_name_or_path=gpt2 \
    --do_train   \
    --save_steps 1000000     \
    --overwrite_output_dir    \
    --num_train_epochs 1     \
    --per_gpu_eval_batch_size 4    \
    --train_data_file=$TRAIN_FILE   \
    --per_gpu_train_batch_size 4

# launch real byteps job
sudo su root
cluster


cd /home/cluster/byteps/examples/pytorch/gpt-2/gpt-2/examples

pkill python
export DMLC_NUM_WORKER=8
export DMLC_NUM_SERVER=8
export NVIDIA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
export DISTRIBUTED_FRAMEWORK=byteps
export BYTEPS_SERVER_ENABLE_SCHEDULE=0
export BYTEPS_SCHEDULING_CREDIT=0
#export BYTEPS_PARTITION_BYTES=4096000
export BYTEPS_PARTITION_BYTES=48000000
export DMLC_PS_ROOT_URI=172.31.35.96
export DMLC_PS_ROOT_PORT=8000
export DMLC_WORKER_ID=7


#export DMLC_ROLE=scheduler && bpslaunch &
export DMLC_ROLE=server && bpslaunch &


export DMLC_ROLE=worker

export ROOT_DIR=${ROOT_DIR:-/home/cluster/byteps/examples/pytorch/gpt-2}
export TRAIN_FILE=${TRAIN_FILE:-$ROOT_DIR/wikitext-2-raw/wiki.train.raw}
export TEST_FILE=${TRAIN_FILE:-$ROOT_DIR/wikitext-2-raw/wiki.test.raw}
export DISTRIBUTED_FRAMEWORK=byteps

cd /home/cluster/byteps/examples/pytorch/gpt-2/gpt-2/examples
bpslaunch python3 /home/cluster/byteps/examples/pytorch/gpt-2/gpt-2/examples/run_lm_finetuning_bps.py \
    --train_data_file=$TRAIN_FILE \
    --output_dir=output  \
    --model_type=gpt2 \
    --model_name_or_path=gpt2 \
    --do_train \
    --save_steps 1000000 \
    --overwrite_output_dir \
    --num_train_epochs 10 \
    --per_gpu_eval_batch_size 4 \
    --per_gpu_train_batch_size 4 

