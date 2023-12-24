+++
date = 2021-02-23
title = 'Ubuntu 18.04服务器部署'
categories = ['linux']
tags = [
    "linux",
    "ubuntu",
    "deployment",
]
+++

# Ubuntu 18.04服务器部署

**更新阿里云源**

cp /etc/apt/sources.list /etc/apt/sources.list.backup

echo > /etc/apt/sources.list

cat <<EOT >> /etc/apt/sources.list

deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse

deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse

EOT

apt update

**# 设置主机名**

192.168.0.8 db2

192.168.0.9 db1

192.168.0.7 app2

192.168.0.10 app1

192.168.0.12 bal

hostnamectl set-hostname bal

vim /etc/hosts

127.0.0.1 app3

**# 添加新硬盘**

wget -O auto_disk.sh http://download.bt.cn/tools/auto_disk.sh && sudo bash auto_disk.sh

**# 优化网络**

wget --no-check-certificate -O tcp.sh https://gitee.com/aolaiqf/Linux-NetSpeed/raw/master/tcp.sh && chmod +x tcp.sh && ./tcp.sh

**# 安装宝塔面板**

wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && sudo bash install.sh

**ubuntu 防火墙使用**

ufw status verbose

ufw app list

ufw allow 8000/tcp

ufw allow 5433/tcp

ufw allow 3000:4000/udp

ufw delete 2

ufw delete allow 22/tcp

ufw enable

ufw disable

ufw reset

ufw logging on

tail -f /var/log/ufw.log