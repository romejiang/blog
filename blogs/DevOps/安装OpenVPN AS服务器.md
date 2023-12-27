+++
date = 2020-09-06
title = '安装OpenVPN AS服务器'
categories = ['devops']
tags = [
    "devops",
    "openvpn",
]
+++

### **参考官方安装文档**

[OpenVPN Access Server Installation Options | OpenVPN](https://openvpn.net/vpn-server-resources/openvpn-access-server-installation-options/)

```bash
## CentOS 7

yum update
timedatectl
timedatectl --help

yum -y install https://as-repository.openvpn.net/as-repo-centos7.rpm
yum -y install openvpn-as
```

### **参考这几篇文章破解链接限制**

[6x's blog](https://6xyun.cn/article/112)

[Centos7 OpenVPN Access Server 安装（最新版+破解多用户限制）](https://www.linuxdevops.cn/2020/11/centos7-openvpn-access-server-installation-latest-version/)

### **重启服务**

```bash
## 关键点，替换破解包后，需要重启服务才能生效
systemctl restart openvpnas 
```

### 添加用户

1. 进入管理界面，
2. 进入 User Permissions 菜单，
3. 添加用户名
4. 修改用户密码
5. 进入 User Profiles 菜单
6. 点击 new profile ，下载配置文件
7. 在本地将配置文件中ip地址替换为公网ip
8. 将配置文件拉入Tunnelblick，连接

### 如果无法连接，检查一下配置文件中的IP是否是公网ip。

### 如果连接成功，也获得了ip。但无法上网。检查一下默认网卡的DNS配置。

可以配置为：

114.114.114.114

8.8.8.8