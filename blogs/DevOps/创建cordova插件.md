+++
date = 2015-07-19
title = '创建 cordova 插件'
categories = ['coding']
tags = [
    "coding",
    "cordova",
    "plugin",
    "phone",
    "mobile",
]
+++


# cordova 

2023-11-15 最新情况
需要 java11
需要 android cmdline tools 不要最新版，用10.0版配合java11
配置 cmdline tools 路径到PATH

### 加入hook
<hook type="before_emulate" src="scripts/before_emulate.sh" />

### 在配置文件中加入需要依赖的包
project.properties
cordova.system.library.2=androidx.documentfile:documentfile:1.0.1

# 创建cordova插件

npm install -g plugman

plugman create --name <pluginName> --plugin_id <pluginID> --plugin_version <version> [--path <directory>] [--variable NAME=VALUE]

plugman create --name YouxiqunSDK --plugin_id cordova-plugin-youxiqun-sdk --plugin_version 0.0.1

plugman create --name YouxiqunSDK --plugin_id cordova-plugin-youxiqun-sdk --plugin_version 0.0.1 --path cordova-plugin-youxiqun-sdk

plugman platform add --platform_name android

plugman createpackagejson <directory>

$ plugman install --platform android --project platforms/android --plugin ../LogicLinkPlugin/

plugman uninstall --platform android --project platforms/android --plugin ../LogicLinkPlugin/