echo "deb http://packages.irontec.com/debian stretch main" >>/etc/apt/sources.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 90D20F5ED8C20040
wget http://packages.irontec.com/public.key -q -O - | apt-key add –
rm /var/lib/mongodb -rf 
apt-get remove mongodb-org-server -y
apt-get update -y && apt-get upgrade -y 
wait
apt-get autoremove -y
ln -T /bin/true /usr/bin/systemctl && apt-get update && apt-get install -y mongodb-org && rm /usr/bin/systemctl
apt-get install mongodb-org-server -y
apt-get update -y
wait
apt-get install -y sngrep