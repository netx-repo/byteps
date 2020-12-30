FROM nvidia/cuda:10.0-cudnn7-devel

ENV USE_BYTESCHEDULER=1
ENV BYTESCHEDULER_WITHOUT_MXNET=1
ENV BYTESCHEDULER_WITHOUT_PYTORCH=1
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"

WORKDIR /home/cluster

# Install dev tools
RUN apt-get update && apt-get install -y git python-dev build-essential
RUN apt-get install -y wget && wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
#RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata

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

# Install GCC 4.8
#RUN apt-get install gcc-4.8 g++-4.8
#RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 100
#RUN update-alternatives --config gcc
#RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 100
#RUN update-alternatives --config g++

# Install tensorflow
#RUN pip install tensorflow-gpu==1.13.2

# Prepare for installing TF
#RUN pip install -U pip six numpy wheel setuptools mock 'future>=0.17.1' enum34
#RUN pip install -U keras_applications==1.0.6 --no-deps
#RUN pip install -U keras_preprocessing==1.0.5 --no-deps
#RUN apt install unzip zip
#RUN apt-get install openjdk-8-jdk
#RUN wget https://github.com/bazelbuild/bazel/releases/download/0.19.2/bazel-0.19.2-installer-linux-x86_64.sh
#RUN chmod +x bazel-0.19.2-installer-linux-x86_64.sh
#RUN ./bazel-0.19.2-installer-linux-x86_64.sh

# Insatll TF
#RUN git clone https://github.com/rivendile/tensorflow.git && cd tensorflow && git checkout r1.13
#RUN cd tensorflow && ./configure
#RUN cd tensorflow && bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package --local_resources 2048,.5,1.0

# Install ByteScheduler for tensorflow
#RUN pip install bayesian-optimization==1.0.1 six
#RUN cd /usr/local/cuda/lib64 && ln -s stubs/libcuda.so libcuda.so.1
#RUN git clone --branch bytescheduler --recursive https://github.com/Rivendile/byteps.git
#RUN cd byteps/bytescheduler && python setup.py install
#RUN rm -f /usr/local/cuda/lib64/libcuda.so.1
#RUN pip install numpy six scipy -t /usr/local/lib/python2.7/dist-packages/
#RUN cd /usr/local/cuda/lib64
#RUN git clone --branch bytescheduler --recursive https://github.com/Rivendile/byteps.git
#RUN cd /usr/local/cuda/lib64/byteps/bytescheduler/bytescheduler/tensorflow
#RUN make

# Set default shell to /bin/bash
SHELL ["/bin/bash", "-cu"]

EXPOSE 2022

COPY container_entrypoint.sh /etc/

RUN chmod +x /etc/container_entrypoint.sh
ENTRYPOINT /etc/container_entrypoint.sh 
