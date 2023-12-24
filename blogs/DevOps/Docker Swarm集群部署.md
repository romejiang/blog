# Docker Swarm集群部署

**创建Swarm**

docker swarm init \
--advertise-addr 172.20.230.5:2377 \
--listen-addr 172.20.230.5:2377

上面命令的ip地址是本服务器的ip，使用ip是为了让其他服务器可以访问到端口

**加入节点**

docker swarm join \
--token SWMTKN-1-3suejfbuq08olge3yiwctperoumxqlmg4227k009wl33u3jwkd-beyvtpxq9pk8pqj8w9gd9r9gv  \
172.20.230.5:2377 \
--advertise-addr 172.20.230.6:2377 \
--listen-addr 172.20.230.6:2377

第一个是mananger服务器的ip，后面两个是worker的本地ip。

**创建网络并添加容器**

docker network create --driver overlay db-net
docker service create --name rs1 --network db-net mongo:3.2 mongod --replSet "rs0"
docker service create --name rs2 --network db-net mongo:3.2 mongod --replSet "rs0"
docker service create --name rs3 --network db-net mongo:3.2 mongod --replSet "rs0"

docker service create --name rs3 --network db-net busybox ping baidu.com

**创建本地数据卷 volume**

docker volume create --driver local \
      --opt type=none \
      --opt device=/root/mongodb/m1 \
      --opt o=bind \
      mongo1

**使用本地数据卷**

本地数据数据卷适合无状态服务，不适合有状态服务，比如mysql，mongodb等。有状态服务下面有基于NFS网络共享数据卷的部署方法。

docker service create \
  --name nginx2 \
  --replicas 1 \
  --mount src=mongo1,dst=/usr/share/nginx/html \
  --constraint 'node.hostname == gpt2' \
  nginx

**SWARM常用命令**

# 创建服务
docker service create \ 
  --image nginx \
  --replicas 2 \
  nginx
 
# 更新服务
docker service update \ 
  --image nginx:alpine \
  nginx
 
# 删除服务
docker service rm nginx
 
# 减少服务实例(这比直接删除服务要好)
docker service scale nginx=0
 
# 增加服务实例
docker service scale nginx=5
 
# 查看所有服务
docker service ls
 
# 查看服务的容器状态
docker service ps nginx
 
# 查看服务的详细信息。
docker service inspect nginx

**实现SWARM集群下 NFS 共享数据卷 volume**

**运行单机NFS容器**

docker run -d \
  --name nfs \
  --privileged \
  -v /root/nfs:/nfsshare \
  -e SHARED_DIRECTORY=/nfsshare \
  -p 2049:2049 \
  itsthenetwork/nfs-server-alpine:latest

**安全服务器需要的NFS工具**

For Ubuntu/Debian: sudo apt-get install -y nfs-common
For RHEL/CentOS: sudo yum install -y nfs-utils

**启动主机NFS模块**

modprobe {nfs,nfsd,rpcsec_gss_krb5}

**测试NFS**

mount -t nfs4 172.20.230.5:/ /mnt/nfs
ll /mnt/nfs
umount  /mnt/nfs

**运行基于NFS的容器**

docker service create \
  --name nginx \
  --replicas 3 \
  -p 80:80 \
  --mount src=172.20.230.5,dst=/usr/share/nginx/html,volume-driver=nfs \
  nginx

**参考**

[https://docs.docker.com/engine/swarm/services/](https://docs.docker.com/engine/swarm/services/)

[https://hub.docker.com/r/itsthenetwork/nfs-server-alpine](https://hub.docker.com/r/itsthenetwork/nfs-server-alpine)

[https://sysadmins.co.za/docker-swarm-persistent-storage-with-nfs/](https://sysadmins.co.za/docker-swarm-persistent-storage-with-nfs/)

[https://github.com/ContainX/docker-volume-netshare](https://github.com/ContainX/docker-volume-netshare)