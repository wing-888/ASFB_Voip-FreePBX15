#!/usr/bin/env bash
cd /root/admin
chmod +x module.sh
chmod +x user.sh
chmod +x tools.sh
./module.sh
wait
./tools.sh
wait
# ./user.sh
cd
rm -Rf /var/www/html/admin/modules/sysadmin
apt-get update -y