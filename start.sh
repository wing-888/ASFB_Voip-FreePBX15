#!/usr/bin/env bash
cd /root/admin # đến thư mục cần thực thi
# thay đổi quyền cho tập tin
chmod +x module.sh 
chmod +x api.sh
chmod +x tools.sh
# thực thi tập tin bên dưới
./module.sh
wait # công cụ phân tích cho asterisk 
./tools.sh
wait # file thiết lập tạo khóa API graphql
./api.sh
cd
# xóa thư mục module hiện tại để update quá trình mới sau khi hoàn tất
rm -Rf /var/www/html/admin/modules/sysadmin
service asterisk restart
wait
# cập nhật cho ổn định
apt-get update -y