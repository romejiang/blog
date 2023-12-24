+++
date = 2016-03-15
title = '部署V2Ray服务器'
categories = ['server']
tags = [
    "server",
    "VPN",
    "GFW",
    "v2ray",
]
+++


一键安装包

[https://github.com/mack-a/v2ray-agent](https://github.com/mack-a/v2ray-agent)


```bash
wget -P /root -N --no-check-certificate "https://raw.githubusercontent.com/mack-a/v2ray-agent/master/install.sh" && chmod 700 /root/install.sh && /root/install.sh
```

关闭防火墙

```bash
systemctl status  firewalld#查看状态
systemctl stop  firewalld#关闭 
systemctl start  firewalld#开启 
systemctl restart  firewalld#重启
systemctl disable  firewalld#关闭开机启动 
firewall-cmd --list-all #查看配置规则
firewall-cmd --zone=public --list-ports #显示所有打开的端口
firewall-cmd --reload #重新载入规则
```

禁用 SELinux

```bash
setenforce 0

vim /etc/selinux/config
```