FROM ubuntu:18.04

LABEL maintainer="hamid.arabnejad@gmail.com"

# define arguments




# install dependencies needs to for FabSim3
RUN apt-get update && \
    apt-get install -y --no-install-recommends sudo git build-essential libopenmpi-dev openmpi-bin && \
    apt-get install -y --no-install-recommends openssh-server openssh-client rsync tree nano systemd && \
    apt-get install -y --no-install-recommends python3-pip python3-dev  && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}


RUN cd /usr/local/bin && \
    ln -s /usr/bin/python3 python && \
    pip3 install --upgrade pip && \
    pip install -U pip setuptools && \
    pip install ruamel.yaml pyyaml matplotlib numpy scipy pytest fabric3==1.13.1.post1 cryptography mpi4py muscle3

# setup FabSim3 folder
RUN mkdir -p /FabSim3 && \
    chmod -R a+rwX /FabSim3
WORKDIR /FabSim3

# setup Flee folder
RUN mkdir -p /flee && \
    chmod -R a+rwX /flee


RUN mkdir /var/run/sshd && mkdir ~/.ssh
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin .*$/PermitRootLogin yes/' /etc/ssh/sshd_config

# config ssh key for FabSim3
RUN ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
RUN chmod 700 ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod og-wx ~/.ssh/authorized_keys
RUN ssh-keyscan -H localhost >> ~/.ssh/known_hosts
RUN touch ~/.ssh/config
RUN echo 'StrictHostKeyChecking no' >> ~/.ssh/config

# customize bashrc
RUN sed -i -e 's/#force_color_prompt=yes$/force_color_prompt=yes/'  /root/.bashrc
RUN echo 'export PS1="\[\033[01;34m\][HiDALGO FabSim3 tutorial]\[\033[01;31m\] \w\[\033[00m\] \$ "' >> /root/.bashrc
RUN echo 'export PATH=/FabSim3/bin:$PATH' >> /root/.bashrc
RUN echo 'export PYTHONPATH=/FabSim3:$PYTHONPATH' >> /root/.bashrc
RUN echo 'chmod -R a+rwX /FabSim3' >> /root/.bashrc
RUN echo 'chmod -R a+rwX /flee' >> /root/.bashrc
RUN echo 'echo "yes \n" | ssh-copy-id -i ~/.ssh/id_rsa.pub root@localhost &> ~/.ssh/log.txt' >> /root/.bashrc


ENTRYPOINT  service ssh restart && /bin/bash
