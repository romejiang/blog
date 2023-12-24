# 安装软路由 PVE + OPENWRT + NAS

## 使用引导安装群晖 7.2
https://www.mspace.cc/archives/834

https://www.123pan.com/s/9YDcVv-ldLN3.html


## **前言**

**因为软件更新比较快，一些方法因为不同的版本可能不一样，我的时间和版本如下，读者可以有效的排错。**

- PVE Version: 6.1-2
- OpenWRT 2020.04.07 1907 Releases 版本，passwall编译版，openwrt-x86-64-combined-squashfs.img
- NAS黑群辉，启动加载器 Jun’s Loader v1.04b DS918+ ，群辉系统   DSM_DS3617xs_23739.pat

下载、安装、实验时间： 2020年4月8日

***后面具体用到时会给出下载地址***

## **安装PVE**

### 下载PVE安装文件

去 [https://www.proxmox.com/en/downloads](https://www.proxmox.com/en/downloads) 下载 proxmox-ve_6.1-2.iso

使用 balenaEtcher.app (Macos) 或者 Win32DiskImager (Windows) 将下载的IOS文件写入U盘。

电脑插入U盘，配置BIOS从U盘启动。

进入安装界面，选择 Install Proxmox VE

然后根据提示一路下一步即可。

**注意：安装过程中，配置IP时，需要规划好IP，保证能链上现在的网络，不要和其他设备的IP冲突。我这里设置的IP是 192.168.0.200**

安装完成，重启机器

用你平时工作的电脑，打开浏览器，访问PVE的管理后台 https://192.168.0.200:8006 。

**注意：前缀必须是 https，其次这个IP就是你安装时配置的IP，如果无法访问，你就尝试ping一下这个IP，还不行就重装。**

**注意：还有可能chrome浏览器登录会报错，可以尝试换safari或者edge浏览器。**

![%E5%AE%89%E8%A3%85%E8%BD%AF%E8%B7%AF%E7%94%B1%20PVE%20+%20OPENWRT%20+%20NAS%2040876451732c4fb88399b9bc087a3f9c/Untitled.png](%E5%AE%89%E8%A3%85%E8%BD%AF%E8%B7%AF%E7%94%B1%20PVE%20+%20OPENWRT%20+%20NAS%2040876451732c4fb88399b9bc087a3f9c/Untitled.png)

打开管理后台大概这个样子。左边的数据中心和pve节点就是本机硬件的管理。下面的都是虚拟机。在pve节点，点右键，可以创建虚拟机。

### 添加网桥

点pve节点，点网络，点创建 Linux Bridge ，桥接端口填入你第二块网卡 enp4s0 的名字。点重启，重启电脑，激活这个网桥。

### **新建OpenWRT虚拟机**

创建虚拟机（OPENWRT）

在管理界面，左侧菜单找到pve节点，点右键，创建虚拟机。

第一步：设置名称：OPENWRT（这里可以随便起，但最好英文）

第二步：不使用任何介质

第三步：默认

第四步：硬盘大小 1GB，设置最小，一会要删除。

第五步：CPU设置，你硬件有多少CPU，给他所有的CPU，比如：星际蜗牛，是1核4线程，那你就设置1核4线程

第六步：内存设置，吧你内存的80%给他，比如有4G内存，4*0.8=3.2G

第七步：网卡选 virtio半虚拟化

第八步：完成

确认完成后会有一台新的虚拟机出现在PVE下面，点击，选择硬件，选择硬盘，点上面的按钮“分离”，然后点删除。把硬盘删除掉。

然后把CDROM也删除掉。

然后添加第二块网卡，点添加，网络设备，桥接选：vmbr1，模型选 ：virtio半虚拟化

### 下载passwall固件

这个固件网上不好找，openwrt-x86-64-combined-squashfs.img.gz ，我是在telegram 频道下载的 [https://t.me/passwall](https://t.me/passwall)。

也可以到这里找找看， [https://passwallopenwrt.github.io/website/](https://passwallopenwrt.github.io/website/)

**注意：尽量下载稳定 Releases 版本。**

**注意：解压固件，如果下载的固件是 .img.gz 后缀的需要解压成 .img**

### 上传固件到 pve 服务器

scp  openwrt-x86-64-combined-squashfs.img root@192.168.0.200:/root/

**将固件加入虚拟机**

点pve节点，点 Shell ，进入pve节点命令行界面

qm importdisk 100 openwrt-x86-64-combined-squashfs.img local-lvm

**注意：这个命令中间有多个空格**

然后点左侧OPENWRT虚拟机，点硬件，可以看到刚刚添加的新硬盘，双击，选择sata，点OK。硬盘加载成功

然后选OPENWRT虚拟机，点选项，双击引导顺序，选择是 sata0

### 点启动，启动openwrt路由

启动后，点控制台，可以进入命令行界面，通过 vi /etc/config/network 修改IP，reboot重启。

之后就可以通过浏览器访问openwrt系统了。

```bash
config interface 'loopback'
	option ifname 'lo'
	option proto 'static'
	option ipaddr '127.0.0.1'
	option netmask '255.0.0.0'

config globals 'globals'
	option ula_prefix 'fdba:a107:9e2e::/48'

config interface 'lan'
	option type 'bridge'
	option ifname 'eth0'
	option proto 'static'
	option ipaddr '10.0.0.254'
	option netmask '255.255.255.0'
	option ip6assign '60'
	option gateway '10.0.0.1'
	option dns '114.114.114.114'

config interface 'wan'
	option ifname 'eth1'
	option proto 'dhcp'
```

## **安装黑群辉**

### 下载固件

到这里 [https://xpenology.club/downloads/](https://xpenology.club/downloads/) 下载黑群辉加载器Jun’s Loader v1.04b DS918+ 版本的 synoboot.img 。

在这里 [https://archive.synology.com/download/DSM/release/6.2.2/24922/](https://archive.synology.com/download/DSM/release/6.2.2/24922/)  下载群辉安装包 DSM_DS918+_24922.pat

创建群辉虚拟机和OPENWRT类似，只是在网卡部分选择 e1000 网卡，然后将群辉加载器 synoboot.img 载入虚拟机。

PVE中virtio网卡使用方法：

安装时先选择e1000网卡，mac地址和引导文件中一致(默认：00:11:32:12:34:56)

安装完成后，先关机，网卡切换成virtio，再开机即可

![%E5%AE%89%E8%A3%85%E8%BD%AF%E8%B7%AF%E7%94%B1%20PVE%20+%20OPENWRT%20+%20NAS%2040876451732c4fb88399b9bc087a3f9c/Untitled%201.png](%E5%AE%89%E8%A3%85%E8%BD%AF%E8%B7%AF%E7%94%B1%20PVE%20+%20OPENWRT%20+%20NAS%2040876451732c4fb88399b9bc087a3f9c/Untitled%201.png)

### 在PVE中连接黑群晖的命令行（console）

在群晖的硬件中，添加串行接口，选  Serial Port (serialO) socket
之后重启群晖。启动后选择控制台 xterm.js


### 添加硬盘

群辉需要大容量硬盘，所以还需要加载硬盘。

pve加载硬盘有三种方法。

**1，硬件直通，加载完整的物理硬盘给虚拟机。**

```jsx
ls -l /dev/disk/by-id #查看物理硬盘编号
ata-WDC_WD80EZAZ-11TDBA0_7HJZ2N5F
ata-ST31000340AS_9QJ1Z96J
qm set 102 --sata1 /dev/disk/by-id/ata-ST31000340AS_9QJ1Z96J
qm set 100 --sata1 /dev/disk/by-id/ata-WDC_WD5000AAKS-60WWPA0_WD-WCAYUU883836  # 加载硬盘给100号虚拟机

ata-TOSHIBA_MG05ACA800E_504UKCIRF56E
```

**2，加载linux逻辑分区。**

qm set 101 --sata2 /dev/sdb3  # 添加逻辑分许
qm set 101 --scsi0 /dev/sdb3  # 添加逻辑分许

**3，加载虚拟硬盘，相当于在pve里建立了一个文件，共虚拟机当硬盘用。**

添加虚拟硬盘可以在管理后台操作，点虚拟机，点硬盘，点添加，选硬盘，输入一个硬盘容量，点OK。

### 启动群辉

设置完群辉虚拟机，启动，然后在浏览器访问 [http://find.synology.com](http://find.synology.com/)，等它找到群辉主机，然后开始常规的群辉安装流程，在这个安装过程中需要用到 DSM_DS3617xs_23739.pat 安装包。

## **PVE硬盘扩容**

通过df -h 或 fdisk -l  找到要扩容的分区。

扩容分区

```bash
lvextend -L +1G /dev/mapper/pve-root
resize2fs /dev/mapper/pve-root
```

扩容虚拟卷

lvextend -L +1G  pve/data

查看扩容后的结果

lvs -a -o name,size,chunk_size

## **黑群辉安装transmission**

[https://packages.synocommunity.com/](https://packages.synocommunity.com/)

翻译成中文

```bash
wget https://github.com/ronggang/transmission-web-control/raw/master/release/install-tr-control-cn.sh
chmod +x install-tr-control-cn.sh
bash install-tr-control-cn.sh
```

黑群晖6.1系统简单安装transmission套件和汉化

[https://post.smzdm.com/p/592201/](https://post.smzdm.com/p/592201/)

## **在esxi上安装openwrt**

#安装需要的软件
brew install qemu gunzip

#解压镜像文件
gunzip openwrt-15.05-x86-64-combined-ext4.img.gz

#转换镜像文件
qemu-img convert -f raw -O vmdk openwrt-15.05-x86-64-combined-ext4.img openwrt-15.05-x86-64-combined-ext4.vmdk

#将vmdk文件上传到esxi

#ssh远程登录esxi
ssh root@esxi

#进入vmdk所在的目录
cd /vmfs/volumes/datastore1/

#释放vmdk文件
vmkfstools -i 'openwrt-19.07.4-x86-64-combined-ext4.vmdk' openwrt-converted.vmdk -d thin

#使用 openwrt-converted.vmdk 文件创建虚拟机

## **修改mac以及sn**

mkdir -p /tmp/boot
cd /dev
mount -t vfat synoboot1 /tmp/boot/

cd /tmp/boot/
ls
cd grub
vim grub.cfg

set vid=0x2111
set pid=0xE222
set sn=DO8YQJPBXVAAF
set mac1=0011321794A8

## **参考**

**[新增6.2.3]ds918 6.2.2引导-支持全系列网卡-支持virtio,e1000,支.....**

http://www.gebi1.cn/thread-295881-1-1.html

**黑群晖安装成功后修改mac以及sn**

http://www.leftso.com/blog/546.html

**DSM 6.2.2 24922 DS918+ Proxmox VE专用引导（支持virtio）**

http://www.nasyun.com/thread-71576-1-1.html

https://www.jianshu.com/p/e267e697e29e

http://find.synology.com/

**vmdk文件报错**

[https://wp.gxnas.com/10122.html](https://wp.gxnas.com/10122.html)

[https://wi1dcard.dev/posts/convert-openwrt-image-to-esxi-vmdk/](https://wi1dcard.dev/posts/convert-openwrt-image-to-esxi-vmdk/)

2080 ti ，cpu i3，

40元

588显卡，