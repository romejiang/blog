+++
date = 2024-05-02
title = '完美部署 FastGPT，本地化 embedding、reranker 模型'
categories = ['ai']
tags = [
    "ai",
    "fastgpt",
    "客户",
    "知识库",
    "RAG",
]
+++

### docker 部署

```shell
curl -O https://raw.githubusercontent.com/labring/FastGPT/main/files/deploy/fastgpt/docker-compose.yml
curl -O https://raw.githubusercontent.com/labring/FastGPT/main/projects/app/data/config.json

# 启动容器
docker-compose up -d
# 等待10s，OneAPI第一次总是要重启几次才能连上Mysql
sleep 10
# 重启一次oneapi(由于OneAPI的默认Key有点问题，不重启的话会提示找不到渠道，临时手动重启一次解决，等待作者修复)
docker restart oneapi
```


### 部署本地 embedding 模型
```shell
# 添加docker镜像
vim docker-compose.yml

  embedding:
    image: jokerwho/bge-large-api:latest
    container_name: embedding
    ports:
      - 6008:6008
    networks:
      - fastgpt
    restart: always
    environment:
      - sk-key=mytoken

# 修改配置文件，bge-large 模型部分是新加的。

vim config.json

"vectorModels": [
    {
      "model": "text-embedding-ada-002",
      "name": "Embedding-2",
      "avatar": "/imgs/model/openai.svg",
      "charsPointsPrice": 0,
      "defaultToken": 512,
      "maxToken": 3000,
      "weight": 100,
      "dbConfig": {},
      "queryConfig": {}
    },
    {
      "model": "bge-large",
      "name": "bge-large",
      "avatar": "/imgs/model/openai.svg",
      "charsPointsPrice": 0,
      "defaultToken": 512,
      "maxToken": 3000,
      "weight": 100,
      "defaultConfig":{},
      "dbConfig": {},
      "queryConfig": {}
    }
  ],


# 每次更新完配置或者yml都需要重启以下
docker compose down
docker compose up -d

```

然后在oneapi里配置 bge-large 模型，之后在 fastgpt 后台创建新的知识库，就可以看到 bge-large 模型了。

**有时添加模型后，网页端显示不出来，请强制刷新网页** 

如果还不明白，请参考官方文档

https://doc.fastai.site/docs/development/custom-models/m3e/



### 部署本地 rerank 模型

```shell
# 添加docker镜像
vim docker-compose.yml

  reranker:
    image: registry.cn-hangzhou.aliyuncs.com/fastgpt/bge-rerank-base:v0.1
    container_name: reranker
    # GPU运行环境，如果宿主机未安装，将deploy配置隐藏即可
    #    deploy:
    #  resources:
    #    reservations:
    #      devices:
    #      - driver: nvidia
    #        count: all
    #        capabilities: [gpu]
    ports:
      - 6006:6006
    networks:
      - fastgpt
    restart: always
    environment:
      - ACCESS_TOKEN=mytoken

# 修改配置文件
vim config.json

"reRankModels": [
  {
    "model": "bge-reranker-base",
    "name": "bge-reranker-base",
    "charsPointsPrice": 0,
    "requestUrl": "http://reranker:6006/v1/rerank",
    "requestAuth": "mytoken"
  }
]

# 每次更新完配置或者yml都需要重启以下
docker compose down
docker compose up -d

```
如果还不明白，请参考官方文档
https://doc.fastai.site/docs/development/custom-models/bge-rerank/

### 修改 fastgpt 版本解决无法rerank的bug
修改 fastgpt 版本为v4.7.1-alpha2
```shell
# 修改docker镜像版本号
vim docker-compose.yml

  image: registry.cn-hangzhou.aliyuncs.com/fastgpt/fastgpt:v4.7.1-alpha2
  # image: registry.cn-hangzhou.aliyuncs.com/fastgpt/fastgpt:v4.7 


# 每次更新完配置或者yml都需要重启以下
docker compose down
docker compose up -d
```



### 修复 postgres 日志报错信息
这个其实可以不用做，但postgres日志里有大量的报错信息，有强迫症的可以处理以下。
```shell
#  添加默认用户
docker exec -it pg sh

#in docker
psql postgres username

#in pg
create user postgres superuser;
create user root superuser;

```

### 修复 postgres 另一个日志报错信息

```shell
# 设置pg权限为 trust
vim pg/data/pg_hba.conf
# 修改如下
# host all all all scram-sha-256
host all all all trust

```

### 禁用 postgres 端口暴露
```shell
vim docker-compose.yml
  
  image: ankane/pgvector:v0.5.0 # git
    container_name: pg
    restart: always
    # 禁用这两行
    #ports: # 生产环境建议不要暴露
    #  - 5432:5432
    networks:
      - fastgpt


# 每次更新完配置或者yml都需要重启以下
docker compose down
docker compose up -d
```

### 几个模型的测试方法

```shell
docker run -d --name bge-large-api -p 6008:6008 jokerwho/bge-large-api:latest
docker run -d --name m3e-large -p 6004:6008 stawky/m3e-large-api:latest


curl --location --request POST 'http://127.0.0.1:6008/v1/embeddings' \
--header 'Authorization: Bearer sk-aaabbbcccdddeeefffggghhhiiijjjkkk' \
--header 'Content-Type: application/json' \
--data-raw '{
  "model": "bge-large-zh-v1.5",
  "input": ["目标：三个菜单栏，体验click、view、media_id 三种类型的菜单按钮，其他类型在本小节学习之后，自行请查询公众平台wiki说明领悟。"]
}'

curl --location --request POST 'http://127.0.0.1:6004/v1/embeddings' \
--header 'Authorization: Bearer sk-aaabbbcccdddeeefffggghhhiiijjjkkk' \
--header 'Content-Type: application/json' \
--data-raw '{
  "model": "bge-large-zh-v1.5",
  "input": ["目标：三个菜单栏，体验click、view、media_id 三种类型的菜单按钮，其他类型在本小节学习之后，自行请查询公众平台wiki说明领悟。"]
}'



```
