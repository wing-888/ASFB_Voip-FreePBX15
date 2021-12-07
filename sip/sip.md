<center> <h1 style="color:red; font-weight: bold;">Config SIP</h1></center>

### Scripts bash: `Sip.sh`

    #!/usr/bin/env bash

Thay đổi tệp để làm dự phòng

    mv /etc/asterisk/sip.conf /etc/asterisk/sip.conf.backup
```bash    
cat <<EOF >/etc/asterisk/sip.conf
[general]   
context=internal
allowguest=no
allowoverlap=no
bindport=5060
bindaddr=0.0.0.0
srvlookup=no
disallow=all
allow=ulaw
alwaysauthreject=yes
canreinvite=no
nat=yes
session-timers=refuse
localnet=192.168.1.0/255.255.255.0

[100]
type=friend
host=dynamic
secret=vudat412
context=internal

[101]
type=friend
host=dynamic
secret=vudat412
context=internal
EOF
```

    mv /etc/asterisk/extensions.conf /etc/asterisk/extensions.conf.backup
```bash    
cat << EOF > /etc/asterisk/extensions.conf 
[internal]
exten => 100,1,Answer()
exten => 100,2,Dial(SIP/100,60)
exten => 100,3,Playback(vm-nobodyavail)
exten => 100,4,VoiceMail(100@main)
exten => 100,5,Hangup()

exten => 101,1,Answer()
exten => 101,2,Dial(SIP/101,60)
exten => 101,3,Playback(vm-nobodyavail)
exten => 101,4,VoiceMail(100@main)
exten => 101,5,Hangup()
EOF
```

    mv /etc/asterisk/voicemail.conf /etc/asterisk/voicemail.conf.backup
```sh    
cat <<EOF >/etc/asterisk/voicemail.conf
[main]
100 => 100
101 => 101
EOF
```
```diff
! service asterisk restart
- fwconsole ma upgradeall
+ fwconsole reload --verbose
@ fwconsole chown
```