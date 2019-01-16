#!/bin/bash

function install_dockerce
{
    apt -y install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
    apt-key fingerprint 0EBFCD88
    add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
    apt update
    apt -y install docker-ce
}

function install_weave
{
    curl -L git.io/weave -o /usr/local/bin/weave
    chmod +x /usr/local/bin/weave
    weave launch
}

function build_basic_image
{
    docker build -t ff/mlnx4 ./dockerfiles/
}

[[ -x $(command -v docker) ]] || install_dockerce
[[ -x $(command -v weave) ]] || install_weave
#docker inspect image ff/mlnx4 >/dev/null 2>&1 || build_basic_image

