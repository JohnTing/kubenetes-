#!/bin/bash
# 初始化 kubenetes 
# 這檔案用來給已安裝 kubelet kubeadm kubectl 的 ubuntu 使用
# 也就是在這之前請先執行 install_k8s.sh
# 以下設定來自
# https://github.com/MicrosoftDocs/Virtualization-Documentation/blob/live/virtualization/windowscontainers/kubernetes/creating-a-linux-master.md

# kubeadm 初始化
kubeadm init --pod-network-cidr=10.244.0.0/16 --service-cidr=10.96.0.0/12

# 讓使用者可以使用 kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 混合叢集設定 Enable mixed-OS scheduling
# mkdir -p kube/yaml && cd kube/yaml

# Confirm that the update strategy of kube-proxy DaemonSet is set to RollingUpdate
kubectl get ds/kube-proxy -o go-template='{{.spec.updateStrategy.type}}{{"\n"}}' --namespace=kube-system

# 使 kube-proxy 只能在 linux 環境上執行 
wget https://raw.githubusercontent.com/Microsoft/SDN/master/Kubernetes/flannel/l2bridge/manifests/node-selector-patch.yml
kubectl patch ds/kube-proxy --patch "$(cat node-selector-patch.yml)" -n=kube-system

# 檢查是否成功
# kubectl get ds -n kube-system

# 給 windows node 要使用的 config，複製到當前位置
cp /etc/kubernetes/admin.conf config
chmod 666 config


# 網路設定，來自
# https://github.com/MicrosoftDocs/Virtualization-Documentation/blob/live/virtualization/windowscontainers/kubernetes/network-topologies.md


# bridged IPv4 traffic to iptables chains
sysctl net.bridge.bridge-nf-call-iptables=1

# Flannel in vxlan mode
# kubectl apply -f kube-flannel_vxlan.yml

# Flannel in host-gateway mode
kubectl apply -f kube-flannel_hostgw.yml

# 使 kube-flannel-ds-amd64 只能在 linux 環境上執行 
kubectl patch ds/kube-flannel-ds-amd64 --patch "$(cat node-selector-patch.yml)" -n=kube-system

# 檢查 pod
# kubectl get ds -n kube-system
kubectl get pods --all-namespaces






