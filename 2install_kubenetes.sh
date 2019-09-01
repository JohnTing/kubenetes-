#!/bin/bash

# 安裝 kubernetes
# 教學來自
# https://github.com/MicrosoftDocs/Virtualization-Documentation/blob/live/virtualization/windowscontainers/kubernetes/creating-a-linux-master.md
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

# 群集的每個 node 不能有同樣的 hostname
# 在使用自動安裝，虛擬機時必須注意
# hostnamectl set-hostname 'new-hostname'

# 暫時關閉 swap 分區
swapoff -a 

# 注釋掉 swap 分區 (使重開機後不會再次啟用 swap 分區)
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# 將 /etc/resolv.conf的 nameserver 127.0.1.1 替換為 nameserver 8.8.8.8 8.8.4.4
# 這主要是解決 coredns crashloopbackoff 問題
sed -i -e 's/nameserver 127.0.1.1/nameserver 8.8.8.8 8.8.4.4/i' /etc/resolv.conf

apt-get update -y && apt-get upgrade -y

# 添加 kubernetes 安裝來源
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo deb http://apt.kubernetes.io/ kubernetes-xenial main | cat > /etc/apt/sources.list.d/kubernetes.list
apt-get update -y

# (測試用)獲得 kubelet 的可安裝版本清單
## apt-cache madison kubelet

# 安裝 kubelet kubeadm kubectl
apt-get install -y kubelet=1.14.5-00 kubeadm=1.14.5-00 kubectl=1.14.5-00







