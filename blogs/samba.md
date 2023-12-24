+++
date = 2023-12-24
title = 'macos samba'
draft = true
publishDate = '2030-12-24'
+++

sudo /usr/local/sbin/samba-dot-org-smbd \
          --debug-stdout \
          --debuglevel=10 \
          --foreground \
          --configfile=/usr/local/etc/smb.conf

cat /Library/LaunchDaemons/org.samba.smbd.plist

sudo launchctl kickstart homebrew.samba

sudo launchctl stop homebrew.samba
sudo launchctl start homebrew.samba

sudo launchctl list

sudo chown root:wheel /Library/LaunchDaemons/org.samba.smbd.plist

sudo launchctl unload -w /Library/LaunchDaemons/org.samba.nmbd.plist
sudo launchctl load -w /Library/LaunchDaemons/org.samba.nmbd.plist
sudo launchctl load -w /Library/LaunchDaemons/org.samba.smbd.plist
sudo launchctl unload -w /Library/LaunchDaemons/org.samba.smbd.plist

sudo /usr/local/Cellar/samba/4.15.5/bin/smbpasswd \
	-c /usr/local/etc/smb.conf \
	-L \
	-a \
	-U \
	rome

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>homebrew.samba</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/local/sbin/samba-dot-org-smbd</string>
      <string>--configfile=/usr/local/etc/smb.conf</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>/usr/local/var</string>
    <key>StandardErrorPath</key>
    <string>/usr/local/var/log/samba.log</string>
    <key>StandardOutPath</key>
    <string>/usr/local/var/log/samba.log</string>
  </dict>
</plist>