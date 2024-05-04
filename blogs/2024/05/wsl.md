+++
date = 2024-05-04
title = 'WSL中开启ssh服务器'
categories = ['devops']
tags = [
    "ssh",
    "wsl",
]
+++


## WSL 中启动 ssh 服务 
```shell
sudo apt install openssh-server

# 修改配置文件
sudo vim /etc/ssh/sshd_config
# 主要设置这两个参数
Port 22
PasswordAuthentication yes

# 然后启动ssh
sudo systemctl start ssh # 开启ssh服务
sudo systemctl enable ssh # 设置ssh服务开机自启

# 如果 systemctl start 报错用以下方法解决

# 先更新wsl到最新版
wsl --update

# 添加下面内容到 /etc/wsl.conf
vim /etc/wsl.conf

[boot]
systemd=true

# 然后到powershell中重启wsl
wsl --shutdown

```


## 设置开启端口转发
windows默认只会将WSL的端口转发到local，所以在localhost上可以登陆ssh，如果想远程访问还需要配置端口转发。

在PowerShell中用管理员权限打开，执行下面的命令，将内网的22端口映射到0.0.0.0的2222端口。
```shell

netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=2222 connectaddress=127.0.0.1 connectport=22
```


