# 内网穿透frp

## **下载服务器代码**

### frp官方网站

[https://github.com/fatedier/frp](https://github.com/fatedier/frp)

### frp下载地址

[https://github.com/fatedier/frp/releases](https://github.com/fatedier/frp/releases)

根据操作系统下载最新版

解压frp文件文件后，文件夹下frp有两个程序，分为服务器端frps、客户端frpc

配置文件也有两个，服务器配置文件frpc.ini、客户端配置frpc.ini

一般在服务器端只需要启动frps。

### **服务器配置**

配置文件名称frps.ini

```bash
[common]
bind_port = 7000  ## 连接端口号
kcp_bind_port = 7000  ##udp kcp协议的端口号
token=1qazxsw2  ## 连接frp服务器的密码
```

### **将frps以linux服务方式启动**

首先将配置文件复制到 /etc/frp/frps.ini

```bash
cp frps.ini /etc/frp/frps.ini
```

然后，frp 解压后有一个 systemd 文件夹，文件夹下的 frps.service 文件就是 linux 系统 systemctl 的配置文件。

将 frps.service 文件复制到 /etc/systemd/system 文件夹下。

```bash
cp systemd/frps.service /etc/systemd/system/
```

然后运行如下命令：

```bash
systemctl enable frps #设置开机启动
systemctl start frps #启动
systemctl stop frps #停止
systemctl status frps #状态
```

**查看服务器日志**

```bash
journalctl -xe|grep frps
journalctl -xe --no-pager -u frps
```

**客户端配置**

这里主要说openwrt下的frpc的配置

[https://www.notion.so//note.youdao.com/src/10139EE6B509453D83F1D11A7E229D84](https://www.notion.so//note.youdao.com/src/10139EE6B509453D83F1D11A7E229D84)

令牌就是服务器的token密码。有了以上配置就可以连通frps服务器了。下面配置内网需要穿透的机器的信息。

[https://www.notion.so//note.youdao.com/src/2A68657EF2AD4FB8B6818AEED812F445](https://www.notion.so//note.youdao.com/src/2A68657EF2AD4FB8B6818AEED812F445)

内网主机和内网端口，这两是一套，这俩连起来就是你在内网可以访问的地址，比如上图：10.0.0.2:80 这个地址必须在内网是可以访问到的。

外网的地址就是图1的服务器地址，加上图的远程端口，比如上图的配置访问 103.235.227.60:8090 就可以访问到 10.0.0.2:80 的内容，就实现了穿透。