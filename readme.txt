2019/9/1 (jot.johnting@gmail.com)
# 目前支援自動建設 master node 的 sh 腳本，而 slave node 的指令大多數都需要人工操作。
# 預設建設 vxlan 網路環境的 master node。

# 安裝環境
# linux master
# Ubuntu 16.04.6 Desktop (64-bit)

# linux worker
# Ubuntu 16.04.6 Server (64-bit)
# Ubuntu 16.04.6 Desktop (64-bit)

# windows worker
# windows server 2019 GUI Standred Evaluation (ver 1809 build 17763.379)

# 在 master node 上以 root 執行
# 將所有檔案放置於 /home/目前使用者/Desktop/
# sudo -i
# 輸入密碼
# cd /home/目前使用者/Desktop/
# 執行 _master_node.sh
# bash _master_node.sh
# 然後等吧