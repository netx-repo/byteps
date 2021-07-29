FROM nvidia/cuda:10.0-devel-ubuntu18.04

ARG https_proxy
ARG http_proxy

ARG BYTEPS_BASE_PATH=/home/cluster
ARG BYTEPS_PATH=$BYTEPS_BASE_PATH/byteps
ARG BYTEPS_GIT_LINK=https://github.com/Rivendile/byteps
ARG BYTEPS_BRANCH=master

WORKDIR /home/cluster
    
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        build-essential \
        tzdata \
        ca-certificates \
        git \
        curl \
        wget \
        vim \
        cmake \
        lsb-release \
        libcudnn7=7.6.0.64-1+cuda10.0 \
        libnuma-dev \
        ibverbs-providers \
        librdmacm-dev \
        ibverbs-utils \
        rdmacm-utils \
        libibverbs-dev \
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools \
        libnccl2=2.4.7-1+cuda10.0 \
        libnccl-dev=2.4.7-1+cuda10.0
        
# install general dependencies
RUN apt-get install -y openssh-server openssh-client vim sudo

# setup cluster user and SSH access to container
ENV USER cluster
RUN useradd -ms /bin/bash $USER && usermod -p '*' $USER && usermod -g root cluster && echo "$USER:$USER" | chpasswd && adduser cluster sudo
ENV HOME /home/$USER
ENV SSHDIR $HOME/.ssh
RUN mkdir -p ${SSHDIR} \
    && touch ${SSHDIR}/sshd_config \
    && ssh-keygen -t rsa -f ${SSHDIR}/ssh_host_rsa_key -N '' \
    && cp ${SSHDIR}/ssh_host_rsa_key.pub ${SSHDIR}/authorized_keys \
    && cp ${SSHDIR}/ssh_host_rsa_key ${SSHDIR}/id_rsa \
    && echo "    IdentityFile ${SSHDIR}/id_rsa" >> ${SSHDIR}/config \
    && echo "    StrictHostKeyChecking no" >> ${SSHDIR}/config \
    && echo "    UserKnownHostsFile /dev/null" >> ${SSHDIR}/config \
    && echo "    Port 2022" >> ${SSHDIR}/config \
    && echo 'Port 2022' >> ${SSHDIR}/sshd_config \
    && echo "HostKey ${SSHDIR}/ssh_host_rsa_key" >> ${SSHDIR}/sshd_config \
    && echo "PidFile ${SSHDIR}/sshd.pid" >> ${SSHDIR}/sshd_config \
    && echo "PasswordAuthentication no" >> ${SSHDIR}/sshd_config \
    && chmod -R 600 ${SSHDIR}/* \
    && chown -R ${USER}:${USER} ${SSHDIR}/

# install framework
# note: for tf <= 1.14, you need gcc-4.9
ARG FRAMEWORK=mxnet
RUN if [ "$FRAMEWORK" = "tensorflow" ]; then \
        pip3 install --upgrade pip; \
        pip3 install -U tensorflow-gpu==1.15.0; \
    elif [ "$FRAMEWORK" = "pytorch" ]; then \
        pip3 install -U numpy==1.18.1 torchvision==0.5.0 torch==1.4.0; \
    elif [ "$FRAMEWORK" = "mxnet" ]; then \
        pip3 install -U mxnet-cu100==1.5.0; \
    else \
        echo "unknown framework: $FRAMEWORK"; \
        exit 1; \
    fi

ENV LD_LIBRARY_PATH /usr/local/cuda/lib64/stubs:$LD_LIBRARY_PATH

ENV BYTEPS_WITH_UCX 1

RUN cd $BYTEPS_BASE_PATH &&\
    git clone --recursive -b $BYTEPS_BRANCH $BYTEPS_GIT_LINK &&\
    cd $BYTEPS_PATH &&\
    python3 setup.py install

# Set default shell to /bin/bash
SHELL ["/bin/bash", "-cu"]

EXPOSE 2022

COPY container_entrypoint.sh /etc/

RUN chmod +x /etc/container_entrypoint.sh
ENTRYPOINT /etc/container_entrypoint.sh
