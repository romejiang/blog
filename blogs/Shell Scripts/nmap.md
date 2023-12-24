+++
date = 2023-02-25
title = 'nmap 常见用法'
categories = ['linux']
tags = [
    "linux",
    "nmap",
    "command line",
]
+++


## 常用命令
```shell
# 扫描主机

nmap -sL 10.0.0.0/24
nmap -sP 10.0.0.0/24 // ping 扫描
nmap -sn 10.0.0.0/24 // –sn方式只对主机进行扫描获取主机名，不扫描其端口。

nmap -P0 10.0.0.0/24  //无ping扫描，扫端口1000个常用端口，比较费时间


#扫描端口

nmap -F 10.0.0.101 //快速扫描，常用的 100 个端口

nmap -sS 10.0.0.101 //TCP sys方式扫描，快速和隐蔽的扫描。
nmap -sU 10.0.0.101 //使用UDP扫描方式
nmap -sN 10.0.0.101 //探测对方TCP端口状态
nmap -p 80,443 10.0.0.101 //指定端口扫描，如多个端口中间用，逗号分隔



nmap -sV 10.0.0.101 //版本探测
nmap -O 10.0.0.101 //操作系统扫描

sudo nmap -sV -O 10.0.0.101

sudo nmap -sS -P0 -sV -O 10.0.0.101
-sS TCP SYN 扫描 (又称半开放，或隐身扫描)
-P0 允许你关闭 ICMP pings，不进行主机发现，直接扫描
-sV 打开系统版本检测
-O 尝试识别远程操作系统



```


## 主机发现
```bash

-sL (列表扫描)：列表扫描是主机发现的退化形式，它仅仅列出指定网络上的每台主机，不发送任何报文到目标主机。
-sP (Ping扫描)：该选项告诉Nmap仅仅进行ping扫描 (主机发现)，然后打印出对扫描做出响应的那些主机。
-A (复合参数)同时探测操作系统指纹和版本检测
-P0/Pn (无ping)：该选项完全跳过Nmap主机发现阶段，通常Nmap在进行高强度的扫描时用它确定正在运行的机器。
-sn (Ping Scan) 只进行主机发现，不进行端口扫描。
-PS/PA/PU/PY[portlist]: 使用TCPSYN/ACK或SCTP INIT/ECHO方式进行发现。
-PE/PP/PM: 使用ICMP echo，timestamp，and netmask 请求包发现主机。
-PU (portlist) (UDP Ping)：使用TCPSYN/ACK或SCTP INIT/ECHO方式进行发现。
-n (不用域名解析)：-n表示不进行DNS解析；-R表示总是进行DNS解析。
--system-dns (使用系统域名解析器)：指定使用系统的DNS服务器。
--traceroute: 追踪每个路由节点。

```
##  端口扫描
```bash

-sS/sT/sA/sW/sM:指定使用TCP SYN/Connect()/ACK/Window/Maimon scans的方式来对目标主机进行扫描。
-sU: 指定使用UDP扫描方式确定目标主机的UDP端口状况。
-sN/sF/sX: 指定使用TCP Null, FIN, and Xmas scans秘密扫描方式来协助探测对方的TCP端口状态。
-sY/sZ: 使用SCTP INIT/COOKIE-ECHO来扫描SCTP协议端口的开放的情况。
-sO: 使用IP protocol 扫描确定目标机支持的协议类型。
-p <port ranges>: 只扫描指定的端口。
-F: 快速 (有限的端口) 扫描。
-r:不要按随机顺序扫描端口。
--scanflags: 定制TCP包的flags。
```

## 服务和版本探测
```bash

-sV (版本探测)：打开版本探测，也可以用-A同时打开操作系统探测和版本探测。
--allports：不为版本探测排除任何端口。
--version-intensity <intensity> ：设置版本扫描强度。
--version-light：打开轻量级模式。
```

## 操作系统探测
```bash

-O：启用操作系统检测，也可以使用-A来同时启用操作系统检测和版本检测。
--osscan-limit： 针对指定的目标进行操作系统检测，如果发现一个打开和关闭的TCP端口时，操作系统检测会更有效。
--osscan-guess;--fuzzy：推测操作系统检测结果，当Nmap无法确定所检测的操作系统时，会尽可能地提供最相近的匹配，Nmap默认进行这种匹配。

```
## 状态输出和保存
```bash

-v ：详细输出扫描状态
-oN ：标准输出，将标准的输出直接写入指定文件。
-oX ：XML输出，以XML输出格式直接写入指定文件。
-oA ：所有格式输出，将所有格式以指定文件名进行输出。

```
