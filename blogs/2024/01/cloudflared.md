+++
date = 2024-01-17
title = '白嫖 cloudflare 的内网穿透'
categories = ['devops']
tags = [
    "devops",
    "ddns",
    "cloudflare",
    "nas",
    "docker",
]
+++

cloudflare 提供了免费的 Tunnel 产品，可以实现内网穿透的功能。但前提是你在 cloudflare 有域名托管。

### Tunnel 有两种使用方式：

  > 第一种是 cloudflare 后台UI界面管理，这种方式简单，但管理多个子域名时需要开多个 Tunnel，比较冗余。
  
  > 第二种是命令行方式，复杂但比较灵活。适合在 nas 的 docker 中运行。这篇文章主要介绍这种方式。

### 首先在有 docker 的环境运行以下命令，获得登录密钥文件。注意命令行输出，运行后会生成一个连接，复制链接到浏览器完成登录和授权。

```shell
docker run --rm -v $PWD/cloudflared:/home/nonroot/.cloudflared cloudflare/cloudflared login
```

### 然后创建 Tunnel ，这里的 `mytunnel` 可以换成你喜欢的名字。 

```shell
docker run --rm -v $PWD/cloudflared:/etc/cloudflared cloudflare/cloudflared tunnel create mytunnel
```

### 完成这两步后，会在当前目录创建一个文件夹 （cloudflared） 和两个文件。类似这样

```shell
tree
./cloudflared/cert.pem
./cloudflared/xxxxxxx-1aa2-46fe-a4ef-5d6ba1b946c8.json
```

### 然后编写配置文件 ./cloudflared/config.yml ，配置文件中的域名 mywebsite.com 改成你自己的域名。xxxxxxx-1aa2-46fe-a4ef-5d6ba1b946c8 也改你自己的。

```
vim config.yml

tunnel: xxxxxxx-1aa2-46fe-a4ef-5d6ba1b946c8

ingress:
  - hostname: www.mywebsite.com
    service: http://192.168.1.100:8080
  - hostname: nas.mywebsite.com
    service: http://192.168.1.100:5000
  - service: http_status:404

```

### 分配一个 CNAME 记录，将流量指向您的 Tunnel。

```shell
# 创建子域名记录，如果有多个子域名，要执行多次。
docker run --rm -v $PWD/cloudflared:/etc/cloudflared cloudflare/cloudflared tunnel route dns xxxxxx-1aa2-46fe-a4ef-5d6ba1b946c8 nas.mywebsite.com
# 验证配置文件
docker run --rm -v $PWD/cloudflared:/etc/cloudflared cloudflare/cloudflared tunnel ingress validate
# 验证访问规则
docker run --rm -v $PWD/cloudflared:/etc/cloudflared cloudflare/cloudflared tunnel ingress rule https://nas.mywebsite.com

```

### 启动 docker 容器。启动后需要等一会才能联通。看到这样的日志就代表联通了。`Registered tunnel connection connIndex=0 connection=xxxxxx-f4e9-4d5e-bb34-323ea53420ee event=0 ip=28.0.11.157 location=kix02 protocol=http2`

```shell
# 测试启动
docker run --rm -v $PWD/cloudflared:/etc/cloudflared cloudflare/cloudflared tunnel run mytunnel
# 正式启动
docker run -d --restart unless-stopped -v $PWD/cloudflared:/etc/cloudflared cloudflare/cloudflared tunnel run mytunnel
```

### 最后测试，对了 cloudflare 会贴心的为你的 Tunnel 套上 ssl 证书，所以访问时用 https 哦。

```
curl -v https://nas.mywebsite.com
```


### 参考

https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/configure-tunnels/local-management/configuration-file/

https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/create-local-tunnel/

https://hub.docker.com/r/cloudflare/cloudflared

