#!/usr/bin/env bash
# nếu server có sd cổng 80 thì ko dc ghi đè sử dụng >> để tránh việc ghi đè
cat << EOF >> /etc/apache2/ports.conf
Listen 8080

<IfModule ssl_module>
  Listen 1443
</IfModule>

<IfModule mod_gnutls.c>
  Listen 1443
</IfModule>

EOF
wait 5s
service apache2 restart