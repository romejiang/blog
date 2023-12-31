+++
date = 2019-12-28
title = 'BTCPay Server 安装配置'
publishDate = '2050-01-01'
categories = ['devops']
tags = [
    "devops",
    "BTC",
    "open source",
    "server",
]
+++

# NodeGUI 安装

windows 10 需要

安装 vs 最新版

安装 vs2022 的 c++桌面开发包 Desktop development with C++

安装 vs2022 的 c++  linux 编译包

安装 cmake

在安装过程中如果因为qode报错，到一下地址下载，并解压到 

node_modules\@nodegui\qode\binaries\

[https://github.com/nodegui/qodejs/releases/tag/v16.4.1-qode](https://github.com/nodegui/qodejs/releases/tag/v16.4.1-qode)

打包的win10系统需要设置 VCINSTALLDIR 环境变量，指向VC运行时库，这样打包后就有vc运行时库安装包在目录下。

```bash
set VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC
```

解压的目录不能有中文，否则也有可能无法打开。