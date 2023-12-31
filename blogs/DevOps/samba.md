+++
date = 2019-12-28
title = 'BTCPay Server 安装配置'
publishDate = '2050-01-01'
categories = ['devops']
tags = [
    "devops",
    "BTC",
    "open source",
    "server",
]
+++

# /etc/nsmb.conf - macOS 11.3 - 2021-04-29
#------------------------------------------------------------------------------
# SMB configuration for macOS 11.3 <-> Synology
#------------------------------------------------------------------------------
# Additional information:
# -----------------------
# https://support.apple.com/de-de/HT211927
# https://support.apple.com/en-us/HT208209
# https://apple.stackexchange.com/questions/309016/smb-share-deadlocks-since-high-sierra
# https://photographylife.com/afp-vs-nfs-vs-smb-performance
# https://support.apple.com/de-de/HT212277
#------------------------------------------------------------------------------
[default]
dir_cache_max_cnt=0

# Use NTFS streams if supported
streams=yes

# Soft mount by default
soft=yes

# Disable signing due to macOS bug
signing_required=no

# Disable directory caching
dir_cache_off=yes

# Lock negotiation to SMB2/3 only
# 7 == 0111  SMB 1/2/3 should be enabled
# 6 == 0110  SMB 2/3 should be enabled
# 4 == 0100  SMB 3 should be enabled
protocol_vers_map=6

# No SMB1, so we disable NetBIOS
port445=no_netbios

# Turn off notifications
notify_off=yes

# SMB Multichannel behavior
# To disable multichannel support completely uncomment the next line
# 要完全禁用多通道支持，请取消下一行的注释
# mc_on=no

# Some Wi-Fi networks advertise faster speeds than the connected wired network. 
mc_prefer_wired=yes
