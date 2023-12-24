# Nginx和ACME做自动ssl代理，基于Docker

### 关键技术

acme通过dns域名服务商的api产生txt记录授权，然后获得证书

docker 容器通过设置 docker的sock文件，可以获取当前网络下所有的容器情况，包括，容器的启动和停止，以及容器的环境变量。这样就可以监听其他容器的启动，并通过环境变量获得域名，然后自动转发。

### 在 docker 容器上运行 acme

[https://github.com/acmesh-official/acme.sh/wiki/Run-acme.sh-in-docker](https://github.com/acmesh-official/acme.sh/wiki/Run-acme.sh-in-docker#3-run-acmesh-as-a-docker-daemon)

### 部署到 docker-compose 中 acme

[https://github.com/acmesh-official/acme.sh/wiki/deploy-to-docker-containers](https://github.com/acmesh-official/acme.sh/wiki/deploy-to-docker-containers)

### 基于 docker-compose 配合 Nginx 做成自动 ssl 代理

[https://github.com/Neilpang/letsproxy](https://github.com/Neilpang/letsproxy)

### nginx 的自动代理镜像

[https://github.com/nginx-proxy/nginx-proxy](https://github.com/nginx-proxy/nginx-proxy)

### 运行docker，开放8080 端口

docker run --name nginx -d -p 443:80 nginx


### 本地部署 acme.sh

curl https://get.acme.sh | sh -s email=my@example.com

alias acme.sh=~/.acme.sh/acme.sh


acme.sh --issue --dns -d v2.bestprompt.cc \
 --yes-I-know-dns-manual-mode-enough-go-ahead-please

### 配置 txt 信息，然后再次获取证书

acme.sh --renew -d v2.bestprompt.cc \
  --yes-I-know-dns-manual-mode-enough-go-ahead-please

### 生成 nginx 需要的证书格式

acme.sh --install-cert -d v2.bestprompt.cc \
--key-file       /home/opc/keys/key.pem  \
--fullchain-file /home/opc/keys/cert.pem 

## --reloadcmd     "service nginx force-reload"

acme.sh --info -d v2.bestprompt.cc