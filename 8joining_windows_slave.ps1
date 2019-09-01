Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
# https://dockermsft.blob.core.windows.net/dockercontainer/docker-19-03-1.zip
# Install-Package 目前似乎有無法下載 docker 安裝檔的問題，所以事先下載並放到指令目錄
Invoke-WebRequest -Uri https://dockermsft.blob.core.windows.net/dockercontainer/docker-19-03-1.zip -OutFile C:\Users\ADMINI~1\AppData\Local\Temp\DockerMsftProvider\Docker-19-03-1.zip
Install-Package -Name Docker -ProviderName DockerMsftProvider

mkdir c:\k
$env:Path += ";C:\k"
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\k", [EnvironmentVariableTarget]::Machine)
$env:KUBECONFIG="C:\k\config"
[Environment]::SetEnvironmentVariable("KUBECONFIG", "C:\k\config", [EnvironmentVariableTarget]::User)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
wget https://raw.githubusercontent.com/Microsoft/SDN/master/Kubernetes/flannel/start.ps1 -o c:\k\start.ps1

$env:HostIP = (
    Get-NetIPConfiguration |
    Where-Object {
        $_.IPv4DefaultGateway -ne $null -and
        $_.NetAdapter.Status -ne "Disconnected"
    }
).IPv4Address.IPAddress

Restart-Computer -Force

# cd c:\k; .\start.ps1 -ManagementIP $env:HostIP

# 重置(刪除) HNSNet，重置能解決大部分網路問題。
# Get-HNSNetwork | Remove-HNSNetwork
