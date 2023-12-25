+++
date = 2016-11-19
title = 'Redis 常用命令'
categories = ['coding']
tags = [
    "coding",
    "redis",
]
+++


### 认证
```shell
auth xxxxx 
# xxx 是秘钥
```
### 列出数据总数
```
CONFIG GET databases

```

### 选择库，查看数据容量
```
select 5
dbsize 
```


