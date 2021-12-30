<center> <h1 style="color:red; font-weight: bold;">Config SIP</h1></center>

### Scripts bash: `Sip.sh`

    #!/usr/bin/env bash

Thay đổi tệp để làm dự phòng

    mv /etc/asterisk/sip.conf /etc/asterisk/sip.conf.backup
```bash    
cat <<EOF >/etc/asterisk/sip.conf
[general]
context=internal
allowhuest=no
allowoverlap=no
bindport=55000
srvlookup=no
udpbindaddr=0.0.0.0
tcpbindaddr=0.0.0.0
tcpenable=no
qualify=yes

[authentication]

[basic-options](!)
dtmfmode=rfc283
context=from-office
type=friend

[natted-phone](!,basic-options)
direcmedia=no
host=dynamic

[public-phone](!,basic-options)
directmedia=yes

[my-codecs](!)
disallow=all
allow=ulaw
allow=gsm
allow=g723
allow=ilbc
allow=g729
allow=alaw

[ulaw-phone](!)
disallow=all
allow=ulaw

[100]
username=100
type=friend
host=dynamic
secret=vudat412
context=internal
qualify=yes
alow=ulaw, alaw

[101]
username=101
type=friend
host=dynamic
secret=vudat412
allow=ulaw,alaw
qualify=yes
EOF
```

    mv /etc/asterisk/extensions.conf /etc/asterisk/extensions.conf.backup
```bash    
cat << EOF > /etc/asterisk/extensions.conf 
[internal]
exten => 100,1,NoOp(calling 100)
exten => n,Dial(SIP/100,20)
exten => n,Hangup

exten => 101,1,NoOp(calling 101)
exten => n,Dial(SIP/101,20)
exten => n,Hangup
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