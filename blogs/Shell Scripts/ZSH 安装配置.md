+++
date = 2016-09-19
title = 'ZSH 安装配置'
categories = ['linux']
tags = [
    "linux",
    "zsh",
    "command line",
]
+++


# ZSH 安装配置

```bash
ip route show

vim /etc/sysconfig/network-scripts/ifcfg-enp4s0

ifup enp4s0

ip route show

yum install -y zsh util-linux-user

curl -L git.io/antigen > antigen.zsh

vim .zshrc

echo $SHELL

chsh -s `which zsh`
```

```bash
source /root/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh
# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle command-not-found
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle agkozak/zsh-z
# Load the theme.
antigen theme robbyrussell
# Tell Antigen that you're done.
antigen apply

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

##source /root/chia-blockchain/activate

alias pa='grep --color "Total time" /root/chia/logs/*'
alias pss='plotman status'
alias pd='plotman details'
alias pi='plotman interactive'
pl(){ pd $1 | sed -n '$p'|sed s/logfile://g | xargs cat }
#alias pl='cat plotman details '
alias pt='grep --color "Total time" /root/chia/logs/*|grep `date +%Y-%m-%d` && grep --color "Total time" /root/chia/logs/*|grep `date +%Y-%m-%d`|wc -l'

alias s='screen'
alias rc='vim ~/.zshrc'

PROMPT="%F{magenta}%n%f"  # Magenta user name
PROMPT+="@"
PROMPT+="%F{blue}${${(%):-%m}#zoltan-}%f" # Blue host name, minus zoltan
PROMPT+=" "
PROMPT+="%F{yellow}%1~ %f" # Yellow working directory
PROMPT+="%# "
```