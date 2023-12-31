+++
date = 2020-10-08
title = '用 shairport-sync 架设 airplay2 网络音响'
categories = ['devops']
tags = [
    "devops",
    "airplay",
    "iphone",
    "ios",
]
+++


### 首先确保本地可以播放声音

##### 下载测试音频

```bash
wget https://www2.cs.uic.edu/~i101/SoundFiles/CantinaBand60.wav
aplay CantinaBand60.wav
```

### 开启USB声卡，需要直通USB芯片组

ESXI | 6.7-7.0如何强制直通板载USB芯片组

http://www.taodudu.cc/news/show-4864661.html?action=onClick


```bash
vi /etc/vmware/passthru.map
# Intel Corporation 8 Series/C220 Series Chipset Family USB xHCI
8086  9d2f  d3d0     default
```

重启exsi
然后在虚拟机中添加PCI USB控制器直通设备



### 通过 alsa 驱动声卡

`sudo apt-get install libasound alsa.utils alsa.oss`

##### 禁用 alsa-restore
`sudo systemctl disable alsa-restore`

##### 启用 alsa-state
```bash
sudo systemctl start alsa-state

aplay -l 

cat /proc/asound/cards

vim /etc/asound.conf

defaults.pcm.card 1
defaults.ctl.card 1
defaults.pcm.device 0
```

### 检查声卡的命令
```bash
lsusb -v

aplay -l 

alsamixer

alsamixer -c 1

aplay -D "default" whatever.wav

shairport-sync --displayConfig

shairport-sync -v --statistics


sudo systemctl enable shairport-sync
sudo systemctl stop shairport-sync
sudo systemctl start shairport-sync

```
### 通过 pulseaudio 驱动声卡

```bash
sudo apt install pulseaudio-utils pulseaudio

pactl list short sources
pactl list short sinks

pactl set-default-source alsa_input.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.mono-fallback

pactl set-default-sink alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo

```
### 关闭防火墙

```bash
sudo ufw disable
```

### 先安装 nqptp，支持 airplay2 需要安装 nqptp。如果只 airplay 不需要安装。

https://github.com/mikebrady/nqptp

https://github.com/mikebrady/shairport-sync

export https_proxy=http://10.0.0.150:7890 http_proxy=http://10.0.0.150:7890 all_proxy=socks5://10.0.0.150:7890


### 安装 nqptp

```bash
git clone https://github.com/mikebrady/nqptp.git
cd nqptp
autoreconf -fi
./configure --with-systemd-startup
make
sudo make install

sudo systemctl enable nqptp
sudo systemctl start nqptp
sleep 1
sudo systemctl status nqptp

```

### 安装 shairport-sync

```bash
git clone https://github.com/mikebrady/shairport-sync.git
cd shairport-sync
autoreconf -fi
./configure --sysconfdir=/etc --with-alsa \
  --with-soxr --with-avahi --with-ssl=openssl --with-systemd --with-airplay-2
make
sudo make install

## 修改声卡名称为 hw:1

vim /etc/shairport-sync.conf

## 测试
shairport-sync -v --statistics

sudo systemctl enable shairport-sync
sudo systemctl start shairport-sync
sleep 1
sudo systemctl status shairport-sync

```

```