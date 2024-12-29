+++
date = 2019-12-28
title = '通过 openai whisper 模型生成字幕'
publishDate = '2050-01-01'
categories = ['devops']
tags = [
    "devops",
    "BTC",
    "open source",
    "server",
]
+++



# 通过 openai whisper 模型生成字幕

```shell
# m-bain/whisperX
subsai /Users/stephen/Movies/JAV/91-0402.mp4 -m openai/whisper -df ./w -f '.ass' 
subsai /Users/stephen/Movies/JAV/91-0402.mp4 -m guillaumekln/faster-whisper -df ./fw -f '.ass' 
subsai /Users/stephen/Movies/JAV/91-0402.mp4 -m m-bain/whisperX -df ./wx --format '.ass' 


# 自动生成字幕
subsai /Users/stephen/Movies/JAV/91-0402.mp4 --model openai/whisper --model-configs '{"model_type": "small"}' --format srt


# 指定字幕语言
subsai ./assets/test1.mp4 --model openai/whisper --model-configs '{"language": "fr"}' --format srt 

# 将字幕中文翻译成英文
subsai /Users/stephen/Movies/douyin/1.mp4 --model openai/whisper --model-configs '{"model_type": "small"}' --format srt -tm 'facebook/m2m100_418M' -tsl zh -ttl en

# 将字幕日文翻译成中文
subsai /Users/stephen/Movies/JAV/hhd800.com@REAL-833.mp4 --model openai/whisper --model-configs '{"model_type": "small","language": "Japanese"}' --format srt -tm 'facebook/m2m100_418M' -tsl ja -ttl zh

subsai /Users/stephen/Movies/JAV/hhd800.com@REAL-833.mp4 --model openai/whisper --model-configs '{"model_type": "small","language": "Japanese"}'

# 测试拷贝网速，rsync命令有问题，限制速度
rsync -a --progress --stats --human-readable  /Volumes/186XXXX1237/迅雷下载/AV/SSIS-878/hhd800.com@SSIS-878.mp4 /Users/stephen/Movies/JAV


time cp /Volumes/186XXXX1237/迅雷下载/AV/SSIS-878/hhd800.com@SSIS-878.mp4 /Users/stephen/Movies/JAV

# 查看samba的状态和参数
smbutil statshares -a

# whisper 模型选择
|  Size  | Parameters | English-only model | Multilingual model | Required VRAM | Relative speed |
|:------:|:----------:|:------------------:|:------------------:|:-------------:|:--------------:|
|  tiny  |    39 M    |     `tiny.en`      |       `tiny`       |     ~1 GB     |      ~32x      |
|  base  |    74 M    |     `base.en`      |       `base`       |     ~1 GB     |      ~16x      |
| small  |   244 M    |     `small.en`     |      `small`       |     ~2 GB     |      ~6x       |
| medium |   769 M    |    `medium.en`     |      `medium`      |     ~5 GB     |      ~2x       |
| large  |   1550 M   |        N/A         |      `large`       |    ~10 GB     |       1x       |

# 翻译模型的选择
'facebook/m2m100_418M', 
'facebook/m2m100_1.2B',
'facebook/mbart-large-50-many-to-many-mmt'

```