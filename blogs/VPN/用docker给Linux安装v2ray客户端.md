# 用docker给Linux安装v2ray客户端

## 更新镜像
```bash
docker pull v2fly/v2fly-core
```
## 创建本地配置文件目录
```bash
mkdir /etc/v2
```
## 配置文件

```shell
vim /etc/v2/config.json

{
  "log": {
    "error": "",
    "loglevel": "info",
    "access": ""
  },
  "inbounds": [
    {
      "listen": "0.0.0.0",
      "protocol": "socks",
      "settings": {
        "udp": true,
        "auth": "noauth"
      },
      "port": "1086"
    },
    {
      "listen": "0.0.0.0",
      "protocol": "http",
      "settings": {
        "timeout": 360
      },
      "port": "1087"
    }
  ],
  "outbounds": [
    {
      "mux": {
        "enabled": true,
        "concurrency": 8
      },
      "protocol": "vmess",
      "streamSettings": {
        "wsSettings": {
          "path": "/mysql",
          "headers": {
            "host": "cdn.bestprompt.cc"
          }
        },
        "tlsSettings": {
          "serverName": "cdn.bestprompt.cc",
          "allowInsecure": false
        },
        "security": "tls",
        "network": "ws"
      },
      "tag": "proxy",
      "settings": {
        "vnext": [
          {
            "address": "cdn.bestprompt.cc",
            "users": [
              {
                "id": "441c2c8c-481c-471f-9dec-086ef80cf01e",
                "alterId": 0,
                "level": 0,
                "security": "aes-128-gcm"
              }
            ],
            "port": 443
          }
        ]
      }
    },
    {
      "tag": "direct",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIP",
        "userLevel": 0
      }
    },
    {
      "tag": "block",
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "none"
        }
      }
    }
  ],
  "dns": {},
  "routing": {
    "settings": {
      "domainStrategy": "IPOnDemand",
    "rules": [
      {
        "type": "field",
        "outboundTag": "direct",
        "domain": ["geosite:cn"]
      },
      {
        "type": "field",
        "outboundTag": "direct",
        "ip": [
          "geoip:cn", 
          "geoip:private"
        ]
      }
    ]
    }
  },
  "transport": {}
}
```

## 启动docker

```shell
sudo docker run -d --name v2ray \
-v /etc/v2:/etc/v2ray \
-p 1087:1087 \
-p 1086:1086 \
v2fly/v2fly-core \
run -c /etc/v2ray/config.json


sudo docker run --name v2ray \
-v /etc/v2:/etc/v2ray \
-p 1087:1087 \
-p 1086:1086 \
v2fly/v2fly-core \
help run

```

## 配置 环境变量
```shell
export http_proxy=http://127.0.0.1:1087
export https_proxy=http://127.0.0.1:1087

export http_proxy=http://172.17.0.1:1087
export https_proxy=http://172.17.0.1:1087



export http_proxy=
export https_proxy=
```

## 配置 wget 代理
```shell
vim ~/.wgetrc
http_proxy = http://127.0.0.1:1087/
https_proxy = http://127.0.0.1:1087/
use_proxy = on
```

## 配置 curl 代理
```shell
vim ~/.curlrc
proxy=http://127.0.0.1:1087
```

## 配置 docker 使用代理
```shell
vim ~/.docker/config.json

{
 "proxies": {
   "default": {
     "httpProxy": "http://172.17.0.1:1087",
     "httpsProxy": "https://172.17.0.1:1087",
     "noProxy": "*.test.example.com,.example.org,127.0.0.0/8,172.0.0.0/8"
   }
 }
}
```