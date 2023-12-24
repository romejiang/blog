# 短网址平台Kutt 的部署

### 安装docker 和 docker-compose

### 安装acme ，获得ssl 证书

```bash
export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087

curl  https://get.acme.sh | sh -s email=my@example.com

alias acme.sh=~/.acme.sh/acme.sh

acme.sh  --issue -d kutt.gearunner.com  --standalone

acme.sh --install-cert -d kutt.gearunner.com \
--key-file ./nginx/ssl/key.pem  \
--fullchain-file ./nginx/ssl/cert.pem
```

### 获取和配置docker-compose

```bash
wget https://github.com/thedevs-network/kutt/blob/develop/docker-compose.yml
wget https://github.com/thedevs-network/kutt/blob/develop/.docker.env
```

### 配置nginx

在 docker-compose.yml 文件中添加下面的 nginx 配置

并给 kutt 服务添加容器名字 container_name: kutt 

```yaml
nginx:
    image: nginx:latest
    container_name: nginx-alpine
    restart: always
    privileged: true
    environment:
      - TZ=Asia/Shanghai
    ports:
      - 80:80
      - 443:443
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - ./nginx/nginx.conf:/etc/nginx/conf.d/default.conf:ro
      - ./nginx/ssl:/etc/nginx/ssl
kutt:
    image: kutt/kutt
    container_name: kutt
```

### 修改 kutt 环境配置

下面列出一下关键配置内容，其他参数按自己的需要配置。

```bash
## 复制环境变量文件
cp .docker.env .env

vim .env 
```

```bash
## 配置域名
DEFAULT_DOMAIN=kutt.gearunner.com

## 注释 RECAPTCHA
#RECAPTCHA_SITE_KEY=
#RECAPTCHA_SECRET_KEY=

## 配置邮件stmp，关键是 MAIL_SECURE=false 
MAIL_HOST=smtp.qq.com
MAIL_PORT=587
MAIL_SECURE=false
MAIL_USER=stephen2099@qq.com
MAIL_FROM=stephen2099@qq.com
MAIL_PASSWORD=xxxxx
```

### 修改nginx 配置文件

```bash
vim nginx/nginx.conf

server {
    listen 80;
    server_name   kutt.gearunner.com;
    return 301 https://$host;
}

server {
    listen 443 ssl http2 default_server;
    listen [::]:443 ssl http2 default_server;

    server_name kutt.gearunner.com;

    ssl_certificate /etc/nginx/ssl/cert.pem;
    ssl_certificate_key /etc/nginx/ssl/key.pem;

    ssl_dhparam /etc/nginx/ssl/dhparam.pem;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS';
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:50m;
    ssl_session_timeout 1d;

    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
    add_header X-Frame-Options SAMEORIGIN;
    add_header X-Content-Type-Options nosniff;
    add_header X-XSS-Protection "1; mode=block";

    location / {
        proxy_pass http://kutt:3000;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_http_version      1.1;
        proxy_cache_bypass      $http_upgrade;

        proxy_set_header Upgrade                $http_upgrade;
        proxy_set_header Connection             "upgrade";
        proxy_set_header Host                   $host;
        proxy_set_header X-Forwarded-For        $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto      $scheme;
        proxy_set_header X-Forwarded-Host       $host;
        proxy_set_header X-Forwarded-Port       $server_port;

    }
}
```

### 启动

```bash
## 启动 docker
docker-compose up -d

## 查看日志，是否有报错
docker-compose logs -f

kutt        | Requiring external module @babel/register
kutt        | Browserslist: caniuse-lite is outdated. Please run:
kutt        | npx browserslist@latest --update-db
kutt        | Using environment: production
kutt        | Already up to date
kutt        | > Ready on http://localhost:3000

## 查看端口是否启动
netstat -tulnp

tcp        0      0 0.0.0.0:3000            0.0.0.0:*               LISTEN      46128/docker-proxy
tcp        0      0 0.0.0.0:443             0.0.0.0:*               LISTEN      46225/docker-proxy
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      46251/docker-proxy
```