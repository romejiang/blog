# nmcli命令配置网络聚合

### **快速方法**

```bash
nmcli con add type bond ifname bond0 con-name bond0 mode balance-alb ipv4.addresses 10.0.0.214/24 ipv4.gateway 10.0.0.254 ipv4.method manual ipv6.method ignore

nmcli connection modify bond0 ipv4.dns '8.8.8.8'

nmcli connection modify bond0 connection.autoconnect-slaves 1

nmcli con show

nmcli con delete enp1s0 ; nmcli con add type bond-slave ifname enp1s0 master bond0

nmcli con show

nmcli connection up bond0

nmcli con show

ifconfig

nmcli con delete enp4s0 ; nmcli con add type bond-slave ifname enp4s0 master bond0; nmcli connection up bond0

ssh root@10.0.0.214

nmcli connection modify bond0 ipv4.addresses '10.0.0.202/24' ; nmcli connection up bond0

cat /proc/net/bonding/bond0

cat /etc/sysconfig/network-scripts/ifcfg-bond0
```

### **查看网络情况**

```bash
nmcli device

nmcli con show
```

### **删除以前的网卡**

```bash
nmcli con delete enp4s0

nmcli con delete enp1s0
```

### **创建新的虚拟汇聚网卡 balance-alb**

```bash
nmcli con add type bond ifname bond0 con-name bond0 mode balance-alb ipv4.addresses 10.0.0.214/24 ipv4.gateway 10.0.0.254 ipv4.method manual ipv6.method ignore
```

### **创建新的虚拟汇聚网卡 active-backup**

```bash
nmcli con add type bond ifname bond0 con-name bond0 mode active-backup ip4 10.0.0.222/24
```

### **添加物理网卡**

```bash
nmcli con add type bond-slave ifname enp1s0 master bond0

nmcli con add type bond-slave ifname enp4s0 master bond0

nmcli con add type bond-slave ifname enp1s0 con-name enp1s0 master bond0

nmcli con add type bond-slave ifname enp4s0 con-name enp4s0 master bond0

nmcli connection add type ethernet slave-type bond con-name bond0-port1 ifname enp7s0 master bond0

nmcli connection add type ethernet slave-type bond con-name bond0-port2 ifname enp8s0 master bond0
```

### **修改网卡配置**

```bash
nmcli connection modify bridge0 master bond0

nmcli connection modify bridge1 master bond0

nmcli connection modify enp5s0 ipv4.addresses '10.0.0.209/24'

nmcli connection modify enp5s0 ipv4.dns '114.114.114.114'

nmcli connection modify enp5s0 ipv4.gateway '10.0.0.254'

nmcli con mod enp5s0 ipv4.method manual

nmcli connection modify bond0 ipv4.addresses '10.0.0.209/24'

nmcli connection modify bond0 ipv4.gateway '10.0.0.254'

nmcli connection modify bond0 ipv4.dns '114.114.114.114'

nmcli connection modify bond0 ipv4.dns '8.8.8.8'

nmcli connection modify bond0 ipv4.dns-search 'example.com'

nmcli connection modify bond0 ipv4.method manual

nmcli connection modify bond0 bond.options "mode=balance-tlb,miimon=1000"
```

### **启动虚拟网卡**

```bash
nmcli connection up bond0

nmcli connection modify bond0 connection.autoconnect-slaves 1

cat /proc/net/bonding/bond0

nmcli connection modify enp5s0 connection.autoconnect-slaves 1

nmcli connection up enp5s0

nmcli con add type ethernet con-name my-office ifname enp0s20f0u2u2u4
```

# **设置思科交换机**

先通过路由器的客户端列表，找到到交换机的ip。然后配置本地网卡到交换机所在的网段。然后telnet 登录交换机

```bash
telnet 172.16.200.1
```

### **查看vlan**

```bash
show vlan
```

### **配置**

```bash
conf t
```

## **选择接口**

```bash
int range g0/2-5
```

### **指向某个vlan**

```bash
swtichport access vlan  xxx
```

### **退出**

```bash
exit
```

查看版本及引导信息 show version

查看运行设置 show running-config

查看开机设置 show startup-config

显示端口信息 show interface type slot/number

显示路由信息 show ip route

### **参考**

https://blog.csdn.net/shinji2k/article/details/86539087

https://www.thegeekstuff.com/2011/10/cisco-switch-vlan/#:~:text=Delete%20VLAN%20on%20Cisco%20Switch&text=Deleting%20a%20VLAN%20is%20as,just%20delete%20the%20VLAN%20192.

https://access.redhat.com/documentation/zh-cn/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/configuring-network-bonding_configuring-and-managing-networking

https://blog.csdn.net/qq_34870631/article/details/115461441