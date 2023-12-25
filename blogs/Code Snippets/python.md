+++
date = 2018-09-28
title = 'Python 创建环境'
categories = ['coding']
tags = [
    "coding",
    "python",
]
+++

# 

### 使用venv创建环境

```shell
## env 是目录名，可以随便写
python -m venv env
source env/bin/activate

## 卸载
source env/bin/deactivate
## 删除环境
rm -Rf env
```


### 查看安装列表

```shell

pip install -r requirements.txt
pip list

```

### 查看版本

```
python -V && pip -V

```

### 导出依赖包

```shell

pip freeze > requirements.txt

pip install -r requirement.txt

```