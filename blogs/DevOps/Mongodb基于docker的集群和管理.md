+++
date = 2019-12-28
title = 'BTCPay Server 安装配置'
publishDate = '2050-01-01'
categories = ['devops']
tags = [
    "devops",
    "BTC",
    "open source",
    "server",
]
+++

# Mongodb基于docker的集群和管理

**初始化环境**

rm -Rf m1 m2 m3 && mkdir m1 m2 m3 && tree m1 m2 m3

**编辑 docker-compose.yml**

version: '3.1'

services:
  mongo0:
    hostname: mongo0
    container_name: mongo0
    image: mongo
    volumes:
      - ./m1:/data/db
    ports:
      - 27017:27017
    restart: always
    # entrypoint: [ "/usr/bin/mongod", "--bind_ip_all", "--replSet", "rs0" ]
    command: --replSet rs0 --bind_ip_all
  
  mongo1:
    hostname: mongo1
    container_name: mongo1
    image: mongo
    volumes:
      - ./m2:/data/db
    ports:
      - 27018:27018
    restart: always
    # entrypoint: [ "/usr/bin/mongod", "--bind_ip_all", "--replSet", "rs0" ]
    command: --replSet rs0 --bind_ip_all --port 27018
 
  mongo2:
    hostname: mongo2
    container_name: mongo2
    image: mongo
    volumes:
      - ./m3:/data/db
    ports:
      - 27019:27019
    restart: always
    # entrypoint: [ "/usr/bin/mongod", "--bind_ip_all", "--replSet", "rs0" ]
    command: --replSet rs0 --bind_ip_all --port 27019

  mongo-express:
    hostname: mongo-express
    container_name: mongo-express
    image: mongo-express
    restart: always
    ports:
      - 8081:8081
    environment:
      ME_CONFIG_MONGODB_SERVER: "mongo0,mongo1:27018,mongo2:27019"
      ME_CONFIG_BASICAUTH_USERNAME: "username"
      ME_CONFIG_BASICAUTH_PASSWORD: "password"

**启动mongod容器**

docker-compose up -d

**登录mongodb ，配置集群**

docker exec -it mongo0 mongo

config={"_id":"rs0","members":[ {"_id":0,"host":"mongo0:27017", priority: 3}, {"_id":1,"host":"mongo1:27018", priority: 2}, {"_id":2,"host":"mongo2:27019", priority: 1} ]}

rs.initiate(config)

rs.status()

**暂停mongod容器**

docker-compose stop

**删除mongod容器**

docker-compose down

**添加删除从机**

rs.add("host:port")

rs.remove("host:port")

**检查复制集状态查询命令**

复制集状态查询：rs.status()

查看oplog状态： rs.printReplicationInfo()

查看复制延迟：  rs.printSlaveReplicationInfo()

查看服务状态详情:   db.serverStatus()

**mongodb 借助一致性全备份加oplogs来添加新节点**

[http://blog.itpub.net/29654823/viewspace-2668650/](http://blog.itpub.net/29654823/viewspace-2668650/)