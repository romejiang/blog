+++
date = 2021-01-05
title = 'Linux 常用命令'
categories = ['linux']
tags = [
    "linux",
    "command line",
]
+++

# Linux 常用命令



** 安装 z jump **


```bash
wget https://raw.githubusercontent.com/rupa/z/master/z.sh

printf "\n\n#initialize Z (https://github.com/rupa/z) \n. ~/z.sh \n\n" >> .bashrc

source ~/.bashrc

```

**screen常用方法**

```bash
alias s='screen'
# 列表
s -ls
# 开启新的
s -S name
# 加入现有的
s -r name
# 从当前推出
control + a / d
# 结束现有的
s -X -S name quit
```

**文件大小排序**

```bash
du -sh * | sort -nr
// 隐藏文件
du -sh .[^.]* | sort -nr
```

**查看linux版本**

```bash
uname -a
lsb_release -a
cat /proc/version
```

**创建Mysql数据库**

```bash
CREATE DATABASE ask CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

=====================================

**shell 脚本常用语法**

```bash
if [ $# > 0 ]; then

if [ "kill" = ""$1 ]; then
```

**CentOS 7 设置DNS**

```bash
nmcli connection show

nmcli con mod eth0 ipv4.dns "114.114.114.114 8.8.8.8"

nmcli con up eth0

nmcli con mod eth0 ipv4.dns "223.5.5.5 8.8.8.8"

cat /etc/sysconfig/network-scripts/ifcfg-eth0
```

**Ubuntu 18.04**

```bash
sudo ln -s  /run/systemd/resolve/resolv.conf  /etc/resolv.conf

sudo vim /etc/systemd/resolved.conf

systemctl restart systemd-resolved.service
```

**服务器测试**

```bash
wget -qO- git.io/superbench.sh | bash

**ping测速**

[http://ping.pe/](http://ping.pe/)

wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/ZBench/master/ZBench.sh && bash ZBench.sh

wget -qO- --no-check-certificate https://raw.githubusercontent.com/oooldking/script/master/[superbench](https://www.oldking.net/tag/superbench/).sh | bash

wget https://raw.githubusercontent.com/oooldking/script/master/[superspeed](https://www.oldking.net/tag/superspeed/).sh && chmod +x superspeed.sh && ./superspeed.sh

wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh"
chmod +x tcp.sh
./tcp.sh
```

**CentOS 7 防火墙**

```bash
systemctl start firewalld.service

systemctl enable firewalld

systemctl disable firewalld

systemctl stop firewalld

systemctl status firewalld

firewall-cmd --state

firewall-cmd --list-all

firewall-cmd --permanent --list-port

firewall-cmd --zone=public --add-port=8080/tcp --permanent

firewall-cmd --zone=public --add-port=443/tcp --permanent

firewall-cmd --zone=public --add-port=22/tcp --permanent

firewall-cmd --reload  ##  必须 reload 才生效

firewall-cmd --zone=public --remove-port=80/tcp --permanent

firewall-cmd --zone=public --remove-port=443/tcp --permanent

firewall-cmd --zone=public --remove-port=22/tcp --permanent

firewall-cmd --zone=public --add-port=8100-8199/tcp --permanent
```

**设置可以访问的网段**

```bash

firewall-cmd --new-zone=dev-access --permanent

firewall-cmd --reload
firewall-cmd --get-zones

firewall-cmd --zone=dev-access --remove-source=172.30.16.0/24 --permanent
firewall-cmd --zone=dev-access --add-source=10.39.12.90/0 --permanent
firewall-cmd --zone=dev-access --add-port=27017/tcp  --permanent
firewall-cmd --zone=dev-access --add-port=6379/tcp  --permanent
firewall-cmd --reload

firewall-cmd --zone=dev-access --list-all 
firewall-cmd --zone=public --list-all
```

**CentOS 7 时间同步**

```bash
timedatectl

timedatectl set-timezone Asia/Shanghai

yum install chrony -y

systemctl start chronyd

systemctl enable chronyd

timedatectl set-ntp yes
```

**Mongo建立索引的原则，字段顺序很重要**

1. 过滤大量数据的字段放在最前面
2. 等值的字段放中间
3. 范围查询和排序的字段放在最后
4. 不同的字段建立不同组合的索引

[https://blog.csdn.net/weidawei0609/article/details/8502206](https://blog.csdn.net/weidawei0609/article/details/8502206)