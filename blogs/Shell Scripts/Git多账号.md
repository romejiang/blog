+++
date = 2021-05-13
title = 'git 多账号'
categories = ['linux']
tags = [
    "linux",
    "git",
    "command line",
]
+++

# Git多账号

```
ssh-keygen -t rsa -C "[xxxxxx@qq.com](mailto:xxxxxx@qq.com)" -f ~/.ssh/second

ssh-add ~/.ssh/id_rsa

ssh-add ~/.ssh/update-awesome

ssh-add ~/.ssh/HenryMartin

ssh-add ~/.ssh/thegamefi

ssh-add ~/.ssh/github.Austin

ssh-add -ls

ssh -T git@github.com

```