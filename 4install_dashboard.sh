# 教學來自 
# https://github.com/kubernetes/dashboard

# 佈署 dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

# 給予 kubernetes-dashboard 所有權限(cluster-admin)(給予所有權限可能有安全問題，建議僅限測試環境使用)
kubectl create clusterrolebinding kubernetes-dashboard -n kube-system --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

# 獲得 kubernetes-dashboard 的 token (用於登入)，儲存於當前目錄的 dashboard_token.txt
kubectl get secret $(kubectl get serviceaccount kubernetes-dashboard -n kube-system -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" -n kube-system | base64 --decode > dashboard_token.txt


# (不確定) 任何一個 account token 都可以用於登入 Dashboard，只是它可能不會有足夠的權限。

# 取得kube-system 所有 service account 的 Name, Namespace, Labels, Annotations, Type, token
# kubectl -n kube-system describe secrets

# 在 master 節點開放內網。(啟動後，終端機會掛起，按下 ctrl c 取消(關閉))
# kubectl proxy

# 用瀏覽器進入 kubernetes-dashboard
# http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/


