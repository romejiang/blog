+++
date = 2021-07-05
title = 'Linux 添加 Swap'
categories = ['devops']
tags = [
    "linux",
    "command line",
]
+++


# Linux添加Swap

```bash
cd /

dd if=/dev/zero of=swapfile count=4096 bs=1MiB

chmod 600 swapfile

mkswap swapfile

swapon swapfile

swapon -s

free -m

vim /etc/fstab

/swapfile   swap    swap    sw  0   0
```