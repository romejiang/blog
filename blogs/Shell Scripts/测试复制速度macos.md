+++
date = 2021-06-12
title = 'MacOS Samba 速度优化'
categories = ['macos']
tags = [
    "macos",
    "command line",
]
+++

```shell
# 以下两个命令，wifi下复制1G内容，13秒

time cp /Volumes/sata1-186XXXX1237/AV/failed/1g3.mp4 .
rsync --progress -a /Volumes/sata1-186XXXX1237/AV/failed/1g3.mp4 ./
rsync -vahrP --info=progress2 /Volumes/sata1-186XXXX1237/AV/failed/1g3.mp4 ./

# wifi模式下最高跑到 70M。应该是wifi的问题。最快也就这样了。wifi6 没测试。

# 网线模式下可以跑到 95M 左右。算跑慢宽带了。

# 优化 macos samba 客户的参数 


sudo vim /etc/nsmb.conf

[default]
  dir_cache_max_cnt=0
  signing_required=no
  protocol_vers_map=6
  mc_prefer_wired=yes
  streams=no
  soft=yes
  signing_required=no
  notify_off=yes
  validate_neg_off=yes



## 禁止隐藏文件
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

sudo sysctl debug.lowpri_throttle_enabled=0 
## 查看速度

sudo smbutil multichannel -a

sudo smbutil statshares -a

```