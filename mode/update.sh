#!/usr/bin/env bash

# /============================================ Thiết lập một số cái đặt cần bổ xung ==================================================\
# Trong này chúng ta chỉ việc cho 1 số cổng được mở trong bản phân phối
# cài đặt module
apt-get update -y
apt-get install vim -y
apt-get install git -y
# upgrade module | cập nhật thêm
fwconsole ma downloadinstall core --edge
fwconsole chown
fwconsole ma upgradeall
#etc.
echo "permitsion key \n"
chmod 600 /etc/asterisk/keys/api_oauth.key
chmod 600 /etc/asterisk/keys/api_oauth_public.key
echo "update packet \n"
apt-get update -y
# Mở cổng trên bản phân phối ubuntu với iptables
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 5060 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 10000:65000 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 55000:55000 -j ACCEPT
apt-get install ufw -y
ufw enable
ufw allow 10000:65000/udp
ufw allow 5060/udp
ufw allow 55000/udp
ufw allow 55000
ufw allow 443/tcp
ufw allow 443
ufw allow 80/tcp  
ufw allow 8080/tcp
ufw allow 4000/tcp
ufw reload
# cập nhật asterisk
fwconsole ma updateall
wait
# reload lại port trên bản phân phối 
sudo ufw reload

# permistion asterisk || fwconsole reload --verbose
chown -R asterisk /var/run/asterisk/

# install codec support mp3 
# Cách sử dụng 
# cd /root/Voip/install/data/var/spool/asterisk/monitor/2021/12/30
# sox -t wav -r 8000 -c 1 <wavfilename> -t mp3 <mp3filename>
apt-get install libsox-fmt-mp3