# SmartDNS和v2ray配置

**在 HAProxy 配置文件中开启 Runtime API**

global
    stats socket ipv4@127.0.0.1:9999 level admin
    stats socket /var/run/hapee-lb.sock mode 666 level admin

**动态调整权重**

echo "show stat" | socat stdio /var/etc/passwall/pid/haproxy.sock | cut -d "," -f 1-2,18-19

echo "set server passwall/hk.nbhd.cloud:443 weight 6" | socat stdio /var/etc/passwall/pid/haproxy.sock

[https://www.haproxy.com/blog/dynamic-configuration-haproxy-runtime-api/](https://www.haproxy.com/blog/dynamic-configuration-haproxy-runtime-api/)

[https://www.haproxy.com/blog/dynamic-configuration-haproxy-runtime-api/](https://www.haproxy.com/blog/dynamic-configuration-haproxy-runtime-api/)

可用的DNS over HTTPS列表

[https://github.com/curl/curl/wiki/DNS-over-HTTPS](https://github.com/curl/curl/wiki/DNS-over-HTTPS)

树莓派3b+ 安装openwrt

将镜像文件写入U盘，注意将gz压缩包解压后再dd写入

重新插拔U盘，载入U盘，打开根目录的config.txt文件，添加

arm_64bit=1

启动树莓派，获取ip，配置dns，配置好网络

opkg update

opkg install luci

tls v2ray 配置

{
  "log": {
    "access": "/var/log/v2ray/access.log",
    "error": "/var/log/v2ray/error.log",
    "loglevel": "warning"
  },
  "dns": {

  },
  "stats": {

  },
  "inbounds": [
    {
      "port": 44222,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "9ddef833-86d1-4c8b-9752-53f6c5c25e2c",
            "alterId": 64
          }
        ]
      },
      "tag": "in-0",
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "path": "/webex"
        }
      },
      "listen": "127.0.0.1"
    }
  ],
  "outbounds": [
    {
      "tag": "direct",
      "protocol": "freedom",
      "settings": {

      }
    },
    {
      "tag": "blocked",
      "protocol": "blackhole",
      "settings": {

      }
    }
  ],
  "routing": {
    "domainStrategy": "AsIs",
    "rules": [
      {
        "type": "field",
        "ip": [
          "geoip:private"
        ],
        "outboundTag": "blocked"
      }
    ]
  },
  "policy": {

  },
  "reverse": {

  },
  "transport": {

  }
}