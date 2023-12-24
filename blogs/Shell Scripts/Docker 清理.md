+++
date = 2018-09-28
title = 'Docker 清理'
categories = ['devops']
tags = [
    "linux",
    "docker",
    "command line",
]
+++

# Docker 清理

### 复制文件到 volume
```bash
docker container create --name dummy -v myvolume:/root hello-world
docker cp c:\myfolder\myfile.txt dummy:/root/myfile.txt
docker rm dummy
```

### **查询镜像（Images）、容器（Containers）和本地卷（Local Volumes）等空间使用大户的空间占用情况**

```bash
docker system df
# 详细信息
docker system df -v
```

### **清理磁盘，删除关闭的容器、无用的数据卷和网络，以及dangling镜像(即无tag的镜像)**

```bash
docker system prune

# 命令清理得更加彻底，可以将没有容器使用Docker镜像都删掉。注意，这两个命令会把你暂时关闭的容器，以及暂时没有用到的Docker镜像都删掉了
docker system prune -a
```

### **删除悬空的镜像**

```bash
docker image prune
```

### **删除无用的容器**

```bash
# 会清理掉所有处于stopped状态的容器
docker container prune
```

### **删除无用的卷**

```bash
 docker volume prune
```

### **删除无用的网络**

```bash
docker network prune
```

### **删除所有悬空镜像，不删除未使用镜像**

```bash
docker rmi $(docker images -f "dangling=true" -q)
```

### **删除所有未使用镜像和悬空镜像**

```bash
docker rmi $(docker images -q)
```

### **删除所有未被容器引用的卷**

```bash
docker volume rm $(docker volume ls -qf dangling=true)
```

### **删除所有已退出的容器**

```bash
docker rm -v $(docker ps -aq -f status=exited)
```

### **删除所有状态为dead的容器**

```bash
docker rm -v $(docker ps -aq -f status=dead)
```

### **查找指定目录下所有大于100M的所有文件**

```bash
 find /var/lib/docker/overlay2/ -type f -size +100M -print0 | xargs -0 du -h | sort -nr
```

### **把/var目录下所有日志文件清空**

```bash
for i in `find /var/lib/docker/containers/ -name *.log*`;do >$i;done
```