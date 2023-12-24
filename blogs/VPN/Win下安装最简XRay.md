+++
date = 2017-12-23
title = 'Win 下安装最简 XRay'
categories = ['server']
tags = [
    "server",
    "VPN",
    "v2ray",
]
+++


# Win下安装最简XRay

### 下载最新的xray-core

[https://github.com/XTLS/Xray-core/releases](https://github.com/XTLS/Xray-core/releases)

### 在本地解压

### 编写配置文件 config.json

```json
{
  "log": {
    "access": "C:\\Users\\MSI-NB\\xray\\_access.log",
    "error": "C:\\Users\\MSI-NB\\xray\\_error.log",
    "loglevel": "info",
    "dnsLog": false
  },
  "inbounds": [
    {
      "port": 8080,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
          }
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
```

### 双击启动 xray