# ESXi上安装OpenWRT

## 在本地（Macos）解压，转换格式

```bash

#安装需要的软件
brew install qemu gunzip

#解压镜像文件
gunzip openwrt-15.05-x86-64-combined-ext4.img.gz

#转换镜像文件
qemu-img convert -f raw -O vmdk openwrt-15.05-x86-64-combined-ext4.img openwrt-15.05-x86-64-combined-ext4.vmdk
qemu-img convert -f raw -O vmdk openwrt-R20.4.8-x64-combined-squashfs.img openwrt-R20.4.8-x64-combined-squashfs.img.vmdk

openwrt20230515.vmdk
## 将vmdk文件上传到esxi

```

## 在 ESXI 虚拟式中再次处理

```bash

#ssh远程登录esxi
ssh root@esxi

#进入vmdk所在的目录
cd /vmfs/volumes/datastore1/

#释放vmdk文件
vmkfstools -i 'openwrt-19.07.4-x86-64-combined-ext4.vmdk' openwrt-converted.vmdk -d thin

#使用 openwrt-converted.vmdk 文件创建虚拟机

vmkfstools -i openwrt-R20.4.8-x64-combined-squashfs.img.vmdk openwrt-R20.4.8-x64-combined-squashfs.img.exsi6.vmdk
```

**参考：**

[https://xmanyou.com/vmware-esxi-install-openwrt/](https://xmanyou.com/vmware-esxi-install-openwrt/)

[https://supes.top/?version=22.03&target=x86%2F64&id=generic](https://supes.top/?version=22.03&target=x86%2F64&id=generic)

[https://www.ikuai8.com/component/download](https://www.ikuai8.com/component/download)