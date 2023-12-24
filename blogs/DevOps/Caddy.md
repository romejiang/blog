# Caddy 极速https服务器

### 静态文件服务器
适合做 h5 app 前端服务器


```Caddyfile
:9005
root * /home/projects/gpt-website
file_server

```


### https 服务器自带证书，反向代理

```shell
# ls
ai.yongsunsoft.com.pem
ai.yongsunsoft.com.key
Caddyfile
```

```Caddyfile
ai.yongsunsoft.com:9004
tls ai.yongsunsoft.com.pem ai.yongsunsoft.com.key
reverse_proxy :9003

```


### caddy validate 测试配置文件是否有效