# [master] 建立 join 指令
kubeadm token create --print-join-command

# 你會獲得 類似以下的指令
# kubeadm join 192.168.132.144:6443 --token 42vyim.j4opt5tzazn425rj     --discovery-token-ca-cert-hash sha256:49f781054a16861e48a121ea36df5cb0b72f489dc5d972e705f528774cbe6cd8

# 在安裝完 kubeadm 的 node 上執行。
