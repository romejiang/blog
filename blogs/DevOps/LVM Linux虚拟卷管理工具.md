# LVM Linux虚拟卷管理工具

### **LVM基本概念**

物理分区 -> PV物理卷 -> VG虚拟卷组 -> LV虚拟卷 -> 文件系统（通过monut）

**注意：对应添加流程看比如容易理解**

### **查看命令**

```bash
fdisk -l # 查看物理分区

pvs  #查看物理卷

vgs #查看虚拟卷组

lvs #查看虚拟卷

df -h # 查看文件系统
```

### **添加流程**

fdisk /dev/sdb
# 使用 fdisk 分区，然后用（t）命令修改分区格式为8e，8e代表 lvm 虚拟卷。或者通过L查看分区类型，找到 Linux LVM的编号

pvcreate  /dev/sdb1
# 用户pvcreate 命令将 /dev/sdb1 分区加入物理卷中

vgcreate newvg /dev/sdb1
# 创建一个名为 newvg 的卷组，使用 /dev/sdb1 物理卷

lvcreate -L 10G -n newlv  newvg
# 创建一个名为 newlv 的虚拟卷，使用 newvg 卷组的容量

mke2fs -t ext4 /dev/newvg/newlv
格式化新创建的虚拟卷，使用 ext4 格式

mount /dev/newvg/newlv /mnt/projects
最后，monut 卷到 /mnt/projects 目录，可以正常使用。

### **扩容流程**

pvcreate /dev/sdc2
# 添加物理卷

vgextend newvg /dev/sdc2
# 将 /dev/sdc2 的容量添加到 myvg 虚拟卷组

lvextend -L +3G /dev/newvg/newlv
# 增加3G容量给 /dev/newvg/newlv 虚拟卷

resize2fs /dev/newvg/newlv
#文件系统确认扩容

e2fsck /dev/newvg/newlv   # 可选
#  检查文件系统是否正确

**注意：只要虚拟卷组里还有剩余容量，可以不用添加物理卷，而给虚拟卷扩容**

**注意：虚拟卷可以容纳不同的物理硬盘和物理分区的容量，然后分配给同一个虚拟卷**

### **缩容流程**

e2fsck -f /dev/newvg/newlv
# 强制卸载并检查文件系统

resize2fs /dev/newvg/newlv 10G
# 缩小容量到 10G ，前提是分区中存的文件小于10G，否则会报错

lvreduce -L 700M /dev/newvg/newlv
# 减少到700M

lvreduce -L -3G /dev/newvg/newlv
# 从虚拟卷中减少 3G 容量

vgreduce newvg  /dev/sdb1
# 删除虚拟卷组中物理卷 /dev/sdb1

### **删除流程**

lvremove /dev/myvg/mylv
vgremove myvg
pvremove /dev/sdc1

**PVE root分区扩容**

lvextend -L +1G /dev/pve/root

resize2fs  /dev/pve/root

### **其他**

如果是xfs 文件系统，需要使用 xfs_growfs  代替  resize2fs 扩容

xfs_growfs

partprobe

查看虚拟卷详情

lvs -a -o name,size,chunk_size

### **参考**

[https://www.jianshu.com/p/eca3869e3f5c](https://www.jianshu.com/p/eca3869e3f5c)

[https://www.d3tt.com/view/255](https://www.d3tt.com/view/255)

[https://www.d3tt.com/view/199](https://www.d3tt.com/view/199)