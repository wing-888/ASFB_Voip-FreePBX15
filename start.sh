#!/usr/bin/env bash

cd /root/admin # đến thư mục cần thực thi
# thay đổi quyền cho tập tin
chmod +x update.sh 
chmod +x api.sh
chmod +x tools.sh
# thực thi tập tin bên dưới
./update.sh
wait # công cụ phân tích cho asterisk 
./tools.sh
wait # file thiết lập tạo khóa API graphql
./api.sh
cd
# xóa thư mục module hiện tại để update quá trình mới sau khi hoàn tất
rm -Rf /var/www/html/admin/modules/sysadmin
service asterisk restart
wait
# change quyền cho key trong thư mục asterisk, tính bảo mật
echo "permitsion key \n"
chmod 600 /etc/asterisk/keys/api_oauth.key
chmod 600 /etc/asterisk/keys/api_oauth_public.key
echo "update packet \n"
# cập nhật cho ổn định
apt-get update -y