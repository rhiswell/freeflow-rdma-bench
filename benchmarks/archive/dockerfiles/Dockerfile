
FROM ubuntu:14.04

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt-get -y update

ADD MLNX_OFED_LINUX-4.0-2.0.0.1-ubuntu14.04-x86_64.tgz /

WORKDIR MLNX_OFED_LINUX-4.0-2.0.0.1-ubuntu14.04-x86_64
RUN echo y | ./mlnxofedinstall --vma --without-fw-update
