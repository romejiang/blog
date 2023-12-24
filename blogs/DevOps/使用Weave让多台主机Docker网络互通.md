# 使用Weave让多台主机Docker网络互通

**安装：**

sudo curl -L git.io/weave -o /usr/local/bin/weave
sudo chmod a+x /usr/local/bin/weave

**启动：**

#主机启动

weave launch

#从机启动

weave launch  172.20.230.5   主机ip

or

weave launch

weave connect 172.20.230.5   主机ip

**设置环境变量：**

eval $(weave env)

将 eval $(weave env)  写入 /etc/profile 文件，以便开机即生效

**检查状态：**

weave version   #查看weave版本
weave status     #查看weave状态

weave status dns

weave status peers

weave status targets

weave status  connections

docker network ls

docker network inspect weave

**防火墙设置：**

如果linux开启了防火墙weave需要开启6783、6784、53端口，让服务器之间通讯。

firewall-cmd --permanent --list-port

firewall-cmd --zone=public --add-port=6783/tcp --permanent

firewall-cmd --zone=public --add-port=6784/tcp --permanent

firewall-cmd --zone=public --add-port=53/tcp --permanent

firewall-cmd --zone=public --add-port=6783/udp --permanent

firewall-cmd --zone=public --add-port=6784/udp --permanent

firewall-cmd --zone=public --add-port=53/udp --permanent

firewall-cmd --reload  ##  必须 reload 才生效

**测试连通情况:**

主机：

docker run --rm  --name c1 -it busybox sh

ping c2

从机：

docker run --rm --name c2 -it busybox sh

ping c1

注意：需要用 Ctrl+p Ctrl+q 退出非后台容器

**设置自启动：**

配置自启服务文件

vim /etc/systemd/system/weave.service

[Unit]
Description=Weave Network
Documentation=http://docs.weave.works/weave/latest_release/
Requires=docker.service
After=docker.service
[Service]
EnvironmentFile=-/etc/sysconfig/weave
ExecStartPre=/usr/local/bin/weave launch --no-restart $PEERS
ExecStart=/usr/bin/docker attach weave
ExecStop=/usr/local/bin/weave stop
[Install]
WantedBy=multi-user.target

如果是从机还需要配置这个文件

vim /etc/sysconfig/weave

PEERS="172.33.16.6 HOST2 .. HOSTn"

然后尝试启动

sudo systemctl start weave

journalctl -xe

如果启动失败，先手动停止，然后再尝试启动

eval $(weave env --restore)

weave stop

设置开机自启动

sudo systemctl enable weave

将 eval $(weave env)  写入 /etc/profile 文件，以便开机即生效

**官方文档**

[https://www.weave.works/docs/net/latest/install/installing-weave/](https://www.weave.works/docs/net/latest/install/installing-weave/)