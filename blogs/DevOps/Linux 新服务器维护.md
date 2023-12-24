# Linux 新服务器维护

**新服务器设置**

**登录授权：**

ssh-copy-id root@poc

**环境优化：**

yum install -y screen

yum -y update

yum install -y screen wget vim net-tools curl git zsh

mkdir install && cd install

git clone https://github.com/powerline/fonts.git

cd fonts
./install.sh

cd ~

curl -L git.io/antigen > antigen.zsh

scp .zshrc root@poc:/root/

chsh -s /bin/zsh

**安装bt面板：**

yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh && sh install.sh

**安装docker：**

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

docker-compose --version

**设置时间同步：**

timedatectl

timedatectl set-timezone Asia/Shanghai

yum install chrony -y

systemctl start chronyd

systemctl enable chronyd