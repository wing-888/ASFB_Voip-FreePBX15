# xây dừng từ bản có sẵn
# như 1 môi trường ta gán chúng với lastest tức là bản mới nhất
ARG CODE_VERSION=latest 
# /---------------------------------FreePBX--------------------------------\
# From ta sẽ xây dựng với tên images được lấy từ phiên bản mới nhất
FROM tiredofit/freepbx:${CODE_VERSION} 
# nhãn thương hiệu cho thấy sản phẩm có thể kiểm tra trong : network inspect 
LABEL maintainer="companydatv@gmail.com"
# bien moi truong asterisk 
ENV ASTERISKUSER asterisk
# thu muc chinh                 
WORKDIR "/root/"
# cap nhat goi, linux nên cập nhật để các gói được ổn định hơn
RUN ["apt-get", "update", "-y"]
# lệnh dưới cho phép chúng ta khởi tạo 1 thư mục trong container 
RUN mkdir -p /root/admin 
# /---------------------------------Copy Folder--------------------------------\
# ở các thư mục này sẽ thực thi khi image được build xong 
# các module sẽ được cài đặt trong quá trình khởi chạy dịch vụ container
# tạo khóa api cho 1 tài khoản mặc định duy nhất
# các công cụ dành cho phân tích gói tin debug ... áp dụng đối với asterisk, các cuộc gọi 
COPY mode/update.sh /root/admin
COPY mode/api.sh /root/admin
COPY mode/tools.sh /root/admin
# /---------------------------------MYSQL--------------------------------\
# |======================================================================|
# COPY mysql/userLogin.sql /docker-entrypoint-initdb.d/
# sư dụng với quyền root 
USER root 
# /---------------------------------RUN Scripts--------------------------------\
# thêm thư mục start vào path init để khởi chạy khi dịch vụ được start hay container được kích hoạt
# đây là thư mục mặc định dành cho các dịch vụ bắt đầu khởi chạy 
ADD start.sh /etc/cont-init.d/
# cập nhật quyền cho thư mục vì trong thư mục này cần phải có quyền để thực thi
RUN chmod u+x /etc/cont-init.d/start.sh
# /---------------------------------PORT--------------------------------\
# mở cổng cho images được đóng gói khi khởi tạo
EXPOSE 8080