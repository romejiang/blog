+++
date = 2023-12-24
title = 'vscode 技巧'
draft = true
publishDate = '2050-01-01'
+++


# vscode 技巧

### 正则表达式查找替换，转换前后顺序

```js
([\d\.]+) (.+)

  "$2": $1
```

```s
10.0.0.201 nas
10.0.0.1 router
10.0.0.2 pass
10.0.0.2 frp
10.0.0.10 esxi
10.0.0.200 pve
10.0.0.220 lpve
10.0.0.189 lnas
10.0.0.4 wifi

```

```yaml
  "nas": 10.0.0.201
  "router": 10.0.0.1
  "pass": 10.0.0.2
  "frp": 10.0.0.2
  "esxi": 10.0.0.10
  "pve": 10.0.0.200
  "lpve": 10.0.0.220
  "lnas": 10.0.0.189
  "wifi": 10.0.0.4
```