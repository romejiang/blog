# 部署新的V2Ray服务器

[https://github.com/mack-a/v2ray-agent](https://github.com/mack-a/v2ray-agent#1vlesstcptlsvlesswstlsvmesstcptlsvmesswstlstrojan-%E4%BC%AA%E8%A3%85%E7%AB%99%E7%82%B9-%E4%BA%94%E5%90%88%E4%B8%80%E5%85%B1%E5%AD%98%E8%84%9A%E6%9C%AC)

66.112.213.93 bwg 

NUZXRGtF39LQ

解析域名

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