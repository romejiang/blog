+++
date = 2023-09-03
title = 'MacOS常用命令'
categories = ['macos']
tags = [
    "macos",
    "command line",
]
+++


# MacOS常用命令

### ack 搜索文件并移动文件

```shell
ack -l --py 'can_short = True'| xargs -I {} mv {} user_data/futures


# 按回车分割字符串，然后遍历，并设置一个{}变量
xargs -I {} 
# 按回车分割字符串，然后遍历
xargs -L1
# 按空格分割字符串，按n后面的数字组合，然后遍历
xargs -n3
# 打印然后执行，用于测试
xargs -t
# 先打印，然后等待确认y，再执行
xargs -p


# 列出所有类型
ack --help-types
# 您可以将此添加到 vim ~/.ackrc。
--type-set=md:ext:md,markdown

```
### 在bash shell 中输出彩色文字

```shell
# echo -e 开启逃逸符
# \003 开启设置
# [xx; 40 - 46 背景色，49 默认 40 黑 41 红
# xx; 30 - 36 前景色 39 默认，30 黑
# xm 字体设置，0 = 取消，1 高亮 4 下划线 5 闪烁 
echo -e "\033[41;32;5m$(date '+%Y-%m-%d %H:%M:%S')"

# 前景和背景的色值，前景是30开始
# 49: Default background color (usually black or blue)
# 40: Black
# 41: Red
# 42: Green
# 43: Yellow
# 44: Blue
# 45: Magenta/Purple
# 46: Cyan

# 字体设置
# 0: Reset/remove all modifier, foreground and background attributes: echo -e "\e[0mNormal Text"
# 1: Bold/Bright: echo -e "Normal \e[1mBold"
# 2: Dim: echo -e "Normal \e[2mDim"
# 4: Underlined: echo -e "Normal \e[4mUnderlined"
# 5: Blink (doesn't work in most terminals except XTerm): echo -e "Normal \e[5mBlink"
# 7: Reverse/Invert: echo -e "Normal \e[7minverted"
# 8: Hidden (useful for sensitive info): echo -e "Normal \e[8mHidden Input"

# 变换各种颜色输出
NAME[0]=42
NAME[1]=43
NAME[2]=44
NAME[3]=45
NAME[4]=46
NAME[5]=41
color=0
for ((i = 1; i < 20; i++)); do
  echo -e "\033[${NAME[$color]};97;5m $(date '+%Y-%m-%d %H:%M:%S') \033[49;39;0m ==== "
  # echo $NAME[$color]
  color=$((color + 1))
  if [ "$color" -gt "5" ]; then
    color=0
  fi
done

https://askubuntu.com/questions/558280/changing-colour-of-text-and-background-of-terminal
```

### youtube-dl 视频下载

```shell
# y 是 youtube-dl 的别称，在 .zshrc 中配置
alias  y='youtube-dl -v '
alias yp='youtube-dl -v --proxy http://127.0.0.1:1087 '

# 查看视频格式
y -F 'https://xxx'

# 下载最好的品质：
y -f best

# 只下载音频，并转成 mp3
y -x --audio-format mp3

# 设置文件名字
y -o 'A REAL Back to School Laptop Guide.mp4'

# 下载带有描述、元数据、注释、字幕和缩略图的视频
--write-description --write-info-json --write-annotations --write-sub --write-thumbnail https://www.youtube.com/watch?v=iJvr0VPsn-s

# PS：
# "https://www.sysgeek.cn/youtube-dl-examples/?amp=1"

```

### macos 锁定、解锁文件

```shell
chflags uchg /etc/hosts #锁定文件
chflags nouchg /etc/hosts #解锁文件

# schg: Set the system immutable flag 系统级只读,不能够重命名、移动、删除、更改内容
# uchg: Set the user immutable flag 用户级只读 不能够更改内容

```

### macos 用命令方式授权文件执行权限
```shell
sudo xattr -r -d com.apple.quarantine  ./Chromium.app
```

**加载NTFS硬盘**

```shell
Diskutil list

Sudo mkdir /Volumes/disk2s1

Sudo mount -t ntfs -o rw,auto,nobrowse /dev/disk2s1 /Volumes/disk2s1
```

**视频压缩**
```shell
ffmpeg -i 'Screen Recording 2021-11-30 at 22.56.56.mov' -r 10 -b:a 32k output.mp4

ffmpeg -i input.mp4 -vcodec libx264 -crf 20 output.mp4

转码1080p

ffmpeg -i test.mp4 -y -strict -2 -b 6000k -bufsize 6000k -an -c:v libx264 -vf scale=1920:1080 test-1080.mp4

转码720p

ffmpeg -i 'Screen Recording 2021-11-30 at 22.56.56.mov' -y -strict -2 -b 3000k -bufsize 3000k -an -c:v libx264 -vf scale=1280:720  -r 16 -filter:v "setpts=0.5*PTS" test-720.mp4

ffmpeg -i 'Screen Recording 2021-11-30 at 22.56.56.mov'  -filter_complex "[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]" -map "[v]" -map "[a]" -r 10 -b:a 32k output.mp4
```
### 视频转音频

```shell
ffmpeg -i abmyj.mp4 -vn -codec copy out.m4a

ffmpeg -i jiazi1.mp4 -vn -c:a libmp3lame -q:a 0 -ar 24000 jiazi1.mp3
ffmpeg -i 00.wav -vn -c:a libmp3lame -q:a 0 -ar 24000 000.wav
 
ffmpeg -i 00.WAV -vn -acodec libfaac -ac 2 -ar 24000 -ab 64k 000.wav
```
### 换转音频频率

```bash
ffmpeg -i "00.WAV" -vn -ac 2 -ar 24000 -acodec pcm_s16le -f wav "000.wav"
ffmpeg -i "00(1).WAV" -vn -ac 2 -ar 24000 -acodec pcm_s16le -f wav "a001.wav"
ffmpeg -i "00(2).WAV" -vn -ac 2 -ar 24000 -acodec pcm_s16le -f wav "a002.wav"
ffmpeg -i "00(3).WAV" -vn -ac 2 -ar 24000 -acodec pcm_s16le -f wav "a003.wav"
ffmpeg -i "00(4).WAV" -vn -ac 2 -ar 24000 -acodec pcm_s16le -f wav "a004.wav"
ffmpeg -i "00(5).WAV" -vn -ac 2 -ar 24000 -acodec pcm_s16le -f wav "a005.wav"
ffmpeg -i "00(6).WAV" -vn -ac 2 -ar 24000 -acodec pcm_s16le -f wav "a006.wav"


for f in *.WAV ; do  "$f" ; done

idx=0
for i in *.WAV ; do 
  ((idx += 1))
  echo "$i" $idx
  ffmpeg -i "$i" -vn -ac 2 -ar 24000 -acodec pcm_s16le -f wav "a00$idx.wav"
done

```

**生成随机数**
```bash
openssl rand -hex 4

openssl rand -base64 6
```

=====================================

=====================================

**MacOS同步文件**
```bash
sudo rsync -vaE --progress /Volumes/SourceName /Volumes/DestinationName

sudo rsync  -r -P /Volumes/SourceName /Volumes/DestinationName

最新

rsync -vahrP /Volumes/2T/Projects ./

rsync --update -raz --progress   www   root@1.0.0.0:/www 只上传更新的

rsync -vahrP --bwlimit=3000 root@10.0.0.3:/mnt/sdb/Shared . > myout.file 2>&1 & 

# 限速后台执行

citl + z后台暂停 , bg 后台执行，fg前台执行，jobs 所有
```

**查找并过滤**

```bash
find . -type d -name node_modules -prune -o -name 'package.json' -print| xargs grep "\"async\"" 
```

**压缩过滤文件**

```bash
tar --exclude='wsserver/node_modules' -zcvf ./c.tar wsserver
```

**Awk的用法**

```shell
# 根据mac地址找到ip，然后去重
ip neigh |grep '5c:e9:1e:b6:92:a4' | awk '{print $1}' | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | awk '!a[$0]++'

PORTS=`netstat -na|grep LISTEN| awk -v FS="[. ]+" '{print $(NF-4); }' | uniq | sort`

# PORTS=`netstat -na|grep LISTEN| awk '{print $4}'|sed -e "s/::1./:/g" -e "s/*./:/g" -e "s/127.0.0.1./:/g" | uniq | sort`

lsof -i :$PORT | awk '{print $2}'| uniq |grep -v PID| xargs ps -p | grep -v PID

netstat -tulnp
```
**测试dns**

```bash
nslookup baidu.com 114.114.114.114

nslookup baidu.com 223.5.5.5

dig raw.githubusercontent.com @192.168.15.1 -p 5335

dig facebook.com @192.168.15.1 -p 5335
```


**让sudo支持touch id**

```bash
sudo sed -i ".bak" '2s/^/auth       sufficient     pam_tid.so\'$'\n/g' /etc/pam.d/sudo
```

**查找命令位置**
```bash
which nvm

whereis nvm

find /usr/local -name nvm
```
=====================================

**查找文件、代码位置**
```bash
grep -Rn --exclude=*.map 'registerCommand' .

grep -Rnw "jQuery.loading.hide()" .

find . -name "*.php" | xargs grep -n --color=auto "select"

find . -name "*.json" | xargs grep -n --color=auto "Ho9wh6gCEkQ3cULpiabG7Bxost49E"
find . -name "*.json" | xargs grep -n --color=auto 'dry_run": false'

sed -i "s/1000/1500/g" `grep -R -l "1000" client`

sed -i "s/https:\/\/fonts\.useso/http:\/\/fonts\.useso/g" `grep -R -l "useso" .`

sed -i "s/https:\/\/ajax\.useso/http:\/\/ajax\.useso/g" `grep -R -l "useso" .`
```
=====================================

**清理docker**
```bash
docker rmi \(docker images | awk '/^<none>/ { print  }'\)

sudo pv -petr CentOS-7-x86_64-DVD-1611.iso | sudo dd of=/dev/disk3 bs=1m

docker system prune

docker system df -v
```
=====================================

**git一些不常用命令**
```bash
git log --oneline --graph --all

所有日志，包括删除的

git reflog    查看所有操作日志，包括reset和删除的记录
git reset --hard HEAD@{3} 
>  退回到任意位置，可以用于恢复删除
>  HEAD@{3} 是 git reflog 命令显示的日志的索引位置

查看文件变动，git恢复删除

git blame [file_name]

部分代码提交

git add -p [file_name]

暂存到stash

git stash -u -k

git stash pop

从别的分支合并一个提交

git cherry-pick [commit_hash]

git merge another

git pull --rebase
```
=====================================

**无条件更新**
```bash
git fetch --all

git reset --hard origin/master
```
=====================================

**Ssh 穿透，微信调试**
```bash
ssh -CNg -R 8099:127.0.0.1:8080 root@101.200.36.133

ack --vue test
```
**访问NTFS**
```bash
diskutil info /Volumes/老毛桃U盘

mkdir ~/NTFS

sudo mount_ntfs -o rw,auto,nobrowse,noowners,noatime /dev/disk2s3 ~/NTFS

sudo mount_ntfs -o rw,nobrowse /dev/disk2s1 ~/NTFS

disk3s3

sudo /usr/local/bin/ntfs-3g /dev/disk2s3 ~/NTFS -olocal -oallow_other

diskutil info /Volumes/NTFSDISK

hdiutil eject /Volumes/NTFSDISK

sudo mount_ntfs -o rw,nobrowse /dev/disk2s1 ~/MYNTFS/

brew cask install mounty

brew cask install osxfuse 
brew install ntfs-3g
```
[https://zhuanlan.zhihu.com/p/115923502](https://zhuanlan.zhihu.com/p/115923502)

**查看macos系统的休眠日志**
```bash
pmset -g log|grep -e "0 Sleep  " -e "0 Wake  " -e "0 DarkWake  "
```
**MacOS查看端口占用**
```bash
lsof -i :7000

sudo lsof -iTCP -sTCP:LISTEN -P -n

netstat -lntup
```
**清理MacTime垃圾**
```bash
tmutil listlocalsnapshots /

tmutil deletelocalsnapshots 2019-08-06-180411

sudo tmutil thinLocalSnapshots / 100000000000 4 删除所有
```
**清理搜索垃圾 spotlight 重建索引**
```bash
mdutil -s / 查看

sudo mdutil -a -i on / off 启动或关闭

sudo mdutil -E /     **重建索引，添加或删除禁止索引文件夹也可以激发重建索引**

关闭：

sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

打开：

sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
```
**重启，⌘Command-R，进入REC，使用磁盘工具，做急救**

**抓取整个网站**
```bash
wget -c -r -np -k -L -p http://www.pinshudata.com/index.html
```
**设置代理**
```bash
networksetup -setautoproxyurl "Wi-Fi" "[http://10.0.0.1:5200/proxy.pac](http://10.0.0.1:5200/proxy.pac)"

networksetup -getautoproxyurl  "Wi-Fi"
```
**shell脚本找到自己所在的目录**
```bash
workdir=$(cd $(dirname $0); pwd)

echo $workdir
```
**查找并删除10天之前的文件**
```bash
find logs -mtime +10 -delete
```
**端口测试**
```bash
nc -zv pocplus1 22

监听端口

nc -lk -p 4422

发送信息

echo 'Hello, world.' | nc a1 4422

UDP

nc -lu -p 5533
echo 'Hello, world.' | nc -u a1 5533
```

**网络测试速度**
```bash
服务端： iperf3 -s

客户端： iperf3 -c 192.168.15.1 -b 1g -t 10 -i 1 -u
```

**[解决Oh My Zsh 在 git 目录下变得卡顿的问题](https://blog.zhenxxin.com/2019/07/21/%E8%A7%A3%E5%86%B3-oh-my-zsh-%E5%9C%A8-git-%E7%9B%AE%E5%BD%95%E4%B8%8B%E5%8F%98%E5%BE%97%E5%8D%A1%E9%A1%BF%E7%9A%84%E9%97%AE%E9%A2%98/)**

```bash
git config --global --add oh-my-zsh.hide-dirty 1

git config --global --add oh-my-zsh.hide-status 1
```
**废话模式更新brews**
```bash
brew update --verbose && brew upgrade --verbose

brew update --verbose

npm --loglevel verbose

npm install --loglevel verbose --registry=https://registry.npm.taobao.org
```
**Time Machine备份速度很慢**

Time Machine备份很慢，google之，发现下面的设置有效：
```bash
sudo sysctl debug.lowpri_throttle_enabled=0

# 备份完再改回来：

sudo sysctl debug.lowpri_throttle_enabled=1
```
备份过程中，可以通过  sudo fs_usage backupd   查看文件访问详情。

**GIT在 zsh 下的简写命令**
```bash
g - git
gst - git status
gl - git pull
gup - git pull --rebase
gp - git push
gd - git diff
gdc - git diff --cached
gdv - git diff -w "$@" | view
gc - git commit -v
gc! - git commit -v --amend
gca - git commit -v -a
gca! - git commit -v -a --amend
gcmsg - git commit -m
gco - git checkout
gcm - git checkout master
gr - git remote
grv - git remote -v
grmv - git remote rename
grrm - git remote remove
gsetr - git remote set-url
grup - git remote update
grbi - git rebase -i
grbc - git rebase --continue
grba - git rebase --abort
gb - git branch
gba - git branch -a
gcount - git shortlog -sn
gcl - git config --list
gcp - git cherry-pick
glg - git log --stat --max-count=10
glgg - git log --graph --max-count=10
glgga - git log --graph --decorate --all
glo - git log --oneline --decorate --color
glog - git log --oneline --decorate --color --graph
gss - git status -s
ga - git add
gm - git merge
grh - git reset HEAD
grhh - git reset HEAD --hard
gclean - git reset --hard && git clean -dfx
gwc - git whatchanged -p --abbrev-commit --pretty=medium
gsts - git stash show --text
gsta - git stash
gstp - git stash pop
gstd - git stash drop
ggpull - git pull origin $(current_branch)
ggpur - git pull --rebase origin $(current_branch)
ggpush - git push origin $(current_branch)
ggpnp - git pull origin $(current_branch) && git push origin $(current_branch)
glp - _git_log_prettily

```