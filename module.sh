#!/usr/bin/env bash
# cài đặt module
apt-get update -y
apt-get install vim -y
fwconsole ma download timeconditions
fwconsole ma download ucp
fwconsole ma download setcid
fwconsole ma download certman
fwconsole ma download calendar
fwconsole ma download webrtc
fwconsole ma download ringgroups
fwconsole ma download backup
fwconsole ma download queues
fwconsole ma download ivr
fwconsole ma download cel
fwconsole ma download userman
fwconsole ma download api
fwconsole ma download restapi
fwconsole ma install restapi
fwconsole ma install userman
fwconsole ma install api
fwconsole ma install cel
fwconsole ma install ivr
fwconsole ma install queues
fwconsole ma install backup
fwconsole ma install ringgroups
fwconsole ma install calendar
fwconsole ma install webrtc
fwconsole ma install certman
fwconsole ma install ucp
fwconsole ma install setcid
fwconsole ma install timeconditions
# nang cap module
fwconsole ma upgrade --edge framework api certman firewall sysadmin
fwconsole ma downloadinstall core --edge
fwconsole ma upgradeall
#etc.
echo "permitsion key \n"
chmod 600 /etc/asterisk/keys/api_oauth.key
chmod 600 /etc/asterisk/keys/api_oauth_public.key
echo "update packet \n"
apt-get update -y
# mở port
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 5060 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 10000:65000 -j ACCEPT
apt-get install ufw -y
ufw enable
ufw allow 10000:65000/udp
ufw allow 5060/udp
ufw allow 80/tcp
ufw reload
fwconsole ma updateall
sudo ufw reload
echo "deb http://packages.irontec.com/debian stretch main" >>/etc/apt/sources.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 90D20F5ED8C20040
apt-get update -y apt-get upgrade -y
wget http://packages.irontec.com/public.key -q -O - | apt-key add –
apt-get update -y
apt-get install -y sngrep
