#!/usr/bin/env bash
# cài đặt module
apt-get update -y
apt-get install vim -y
# upgrade module
fwconsole downloadinstall core --edge
fwconsole ma upgradeall
#etc.
echo "permitsion key \n"
chmod 600 /etc/asterisk/keys/api_oauth.key
chmod 600 /etc/asterisk/keys/api_oauth_public.key
echo "update packet \n"
apt-get update -y
# open port
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 5060 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 10000:65000 -j ACCEPT
apt-get install ufw -y
ufw enable
ufw allow 10000:65000/udp
ufw allow 5060/udp
# ufw allow 80/tcp  
ufw allow 8080/tcp
ufw reload
fwconsole ma updateall
wait
sudo ufw reload