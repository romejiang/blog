+++
date = 2024-07-11
title = 'Github无法访问的解决访问'
categories = ['ai']
tags = [
    "ai",
    "fastgpt",
    "客户",
    "知识库",
    "RAG",
]
+++

### Github无法访问的解决访问

访问这个地址：https://ping.chinaz.com/github.com

选出最快的IP地址

修改/etc/hosts


```
vim /etc/hosts

192.30.255.112 github.com
192.30.255.112 raw.githubusercontent.com

```


刷新DNS
```shell
# Ubuntu
sudo resolvectl flush-caches
# Windows
ipconfig /flushdns

```


