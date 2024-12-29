+++
date = 2024-12-29
title = '最简 自建 docker 仓库镜像'
categories = ['docker']
tags = [
    "docker",
    "镜像",
    "caddy",
    "防火墙",
    "GFW",
]
+++

### 环境需要

需要一个域名，需要一台外网的服务器。

### 解析域名

首先解析三个域名到服务器。
```
dockerhub.example.com
auth.dockerhub.example.com
production.dockerhub.example.com
```

### 安装caddy

```shell
# centos
yum install -y caddy

# ubuntu
apt install -y caddy

```

### 配置caddy

```shell
mkdir caddy
cd caddy
vim /etc/caddy/Caddyfile

```

```Caddyfile

dockerhub.example.com {
	reverse_proxy https://registry-1.docker.io {
		header_up Host {http.reverse_proxy.upstream.hostport}
		header_down WWW-Authenticate "https://auth.docker.io" "https://auth.dockerhub.example.com"
		header_down Location "https://production.cloudflare.docker.com" "https://production.dockerhub.example.com"
	}
}

auth.dockerhub.example.com {
	reverse_proxy https://auth.docker.io {
		header_up Host {http.reverse_proxy.upstream.hostport}
	}
}

production.dockerhub.example.com {
	reverse_proxy https://production.cloudflare.docker.com {
		header_up Host {http.reverse_proxy.upstream.hostport}
	}
}

```

### 测试启动caddy

```shell
caddy run 
```

### 测试从镜像下载images

在一台国内的电脑上执行以下命令

```shell
docker run docker.example.com/library/hello-world
```

### 正式启动caddy
```shell
caddy start
```

### 停止caddy
```shell
caddy stop

caddy status

caddy reload
```
