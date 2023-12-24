# Android刷机小米 Mix2 并ROOT

## 解锁BL

首先要解锁，不解锁后面的流程都无法完成。小米解锁需要向官方申请。
否则需要插卡186小时后。才能申请。

MTK联发科的小米/红米机器可以暴力解锁BL。
https://github.com/bkerler/mtkclient


## 线刷底包

刷国际版，android 8.0 的版本成功了。其他的都没有成功。

chiron_global_images_V10.3.5.0.ODEMIXM_20190528.0000.00_8.0_global_92f50efa6b.tgz

## 刷 TWRP

```shell
adb reboot bootloader
fastboot flash recovery twrp.img
fastboot reboot
```

注意：重启后按住音量键上，强制进入 TWRP ，激活TWRP

>***这步很重要，不然会固定不住TWRP。***

进入TWRP将 SuperSU 或者 Magisk 上传到手机，然后通过 zip 刷入系统。

然后双清，格式化，重启。root成功。

## 如果进入 TWRP 发现文件夹乱码
使用双清界面的Data格式化，然后在重启到 recovery 模式，进入TWRP。这是就可以写入了。
通过数据线复制root相关的app，比如 Magisk 。就完成刷机了。




### MTK BL 解锁
打开 一键解锁BL工具。

把手机彻底关机。同时按住音量上 和 音量下。然后插入USB线，插入USB线时会启动手机。这是按键不要松开，会看到解锁界面有信息轮动，最终显示 success ，如果显示 error ，就重复上面的过程。

下载工具和驱动
https://www.52pojie.cn/thread-1686248-1-1.html
https://kongbaixx.lanzouj.com/iMFvp0bde8jg

### 红米Note9 5G cannon 按这个教程刷，不同的机器刷机命令还不太一样。要查询一下。

https://unofficialtwrp.com/twrp-3-4-2-root-redmi-note-9-5g-cannon/