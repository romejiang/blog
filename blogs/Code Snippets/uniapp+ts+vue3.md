+++
date = 2022-11-19
title = '搭建 uniapp + ts + vue3 + windicss 项目'
categories = ['coding']
tags = [
    "coding",
    "vuejs",
    "ts",
    "windicss",
]
+++


## 新组合 uniapp + ts + vue3 + unocss + mini-router

npx degit romejiang/uni-preset-vue#vite-ts FinCRM

pnpm i

## 安装常用库
pnpm i pinia@2.0.23
pnpm i @vueuse/core
pnpm i -D naive-ui

## 安装 uni-ui 的依赖
pnpm i sass sass-loader@10.1.1 -D

## 修复 vite 访问内置库报错
pnpm i node-stdlib-browser
pnpm i -D vite-plugin-node-stdlib-browser

## 安装 supabase
pnpm i -S @supabase/supabase-js


#  默认已安装的内容
## 安装 unocss
pnpm add -D unocss

## 安装 路由
pnpm i uni-mini-router uni-parse-pages unplugin-auto-import -D

## 安装 uni类型支持
pnpm i -D @uni-helper/uni-app-types

```js
// tsconfig.json
{
  "compilerOptions": {
    "types": ["@dcloudio/types", "@uni-helper/uni-app-types"]
  },
  "vueCompilerOptions": {
    "nativeTags": ["block", "component", "template", "slot"]
  },
  "include": ["src/**/*.vue"]
}
```
## 用命令行创建 uniapp + ts + vue3 项目

npm install -g @vue/cli@4

https://github.com/dcloudio/uni-preset-vue


// 创建以 javascript 开发的工程
npx degit dcloudio/uni-preset-vue#vite my-vue3-project
// 创建以 typescript 开发的工程
npx degit dcloudio/uni-preset-vue#vite-ts my-vue3-project

npm i 

npm run dev:h5


https://www.yii666.com/blog/361919.html


## 安装 windicss 支持
```shell
# 安装 uniapp 支持 windcss
pnpm i vite-plugin-windicss windicss -D
# 安装小程序支持 windcss，如果是打包h5，则不需要安装
pnpm i @dcasia/mini-program-tailwind-webpack-plugin -D


// vite.config.js

import WindiCSS from 'vite-plugin-windicss';
import MiniProgramTailwind from '@dcasia/mini-program-tailwind-webpack-plugin/rollup';

export default {
  plugins: [
    WindiCSS(),
    MiniProgramTailwind()
  ]
}

//windi.config.js
export default {
  preflight: false,
  prefixer: false,
  extract: {
    // 忽略部分文件夹
    exclude: ['node_modules', '.git', 'dist']
  },
  corePlugins: {
    // 禁用掉在小程序环境中不可能用到的 plugins
    container: false
  }
}

// main.js
import 'virtual:windi.css'

# vim vite.config.js

# import WindiCSS from 'vite-plugin-windicss'
# import {
# 	defineConfig
# } from 'vite'
# import uni from '@dcloudio/vite-plugin-uni'
# export default defineConfig({
# 	plugins: [
# 		WindiCSS({
# 			scan: {
# 				dirs: ['.'], // 当前目录下所有文件
# 				fileExtensions: ['vue', 'js', 'ts'], // 同时启用扫描vue/js/ts
# 			},
# 		}),
# 		uni(),
# 	],
# })



# vim main.js 

# // import 'virtual:windi.css'

# // 引入组件和工具类
# import 'virtual:windi-components.css'
# import 'virtual:windi-utilities.css'
```

## 安装 uni-ui

https://ext.dcloud.net.cn/plugin?id=55
进入uni组件下载站，点击 uni-ui 安装按钮，在 hbuilder 中安装
然后安装 sass 编译器
```shell
pnpm i sass sass-loader@10.1.1 -D

```
uni-ui 演示网站
https://hellouniapp.dcloud.net.cn/pages/component/button/button


## vue 打包

uniapp 打包 需要配置 manifest.json
```json
"h5" : {
    "router" : {
        "base" : "./",
        "mode" : "hash"
    }
}
```

nginx伪静态需要配置

```yaml
location / {
  try_files $uri $uri/ /index.html;
}
```

## windicss 兼容 微信小程序
https://github.com/dcasia/mini-program-tailwind

https://www.craft.me/s/Wx2f9cjGwyZYOx/x/8049AFBE-6BA8-4513-B2A7-528633DE83E8

https://developers.weixin.qq.com/community/develop/article/doc/000c428f5206a0f87e6d1582e5ec13

## 后台直接使用 这个项目 vue3 + ts + element-plus + windi
https://element-plus-admin-doc.cn/guide/#npm-script
