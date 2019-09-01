#!/bin/bash

# 教學來自
# https://docs.docker.com/install/linux/docker-ce/ubuntu/

# 如果使用 ubuntu server ，則必須註釋掉 deb cdrom:
# 避免因 apt-get update 找不到 cdrom 的安裝源而終止
sed -i '/cdrom:/ s/^\(.*\)$/#\1/g' /etc/apt/sources.list

apt-get update

apt-get install -y openssh-server
apt-get install -y vim

# Install Docker CE
## Set up the repository:
### Install packages to allow apt to use a repository over HTTPS
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

### Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

### Add Docker apt repository.
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update

# (測試用)獲得 docker 的可安裝版本清單
## apt-cache madison docker-ce

## Install Docker CE.
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# 確認 docker 版本
docker version
