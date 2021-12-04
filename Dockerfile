# xây dừng từ bản có sẵn
FROM tiredofit/freepbx

LABEL maintainer="hacker@gmail.com"
# bien moi truong asterisk 
ENV ASTERISKUSER asterisk
ENV module=/etc/cont-init.d
# co the bo qua
ENV apioauth=/etc/asterisk/keys/api_oauth.key
ENV apioauthpublic=/etc/asterisk/keys/api_oauth_public.key

# thu muc chinh                 
WORKDIR "/root/"
# cap nhat goi
RUN ["apt-get", "update", "-y"] 
# CMD is for runtime (container creation), not for building the image
# tệp module chỉ các số module ... đọc thêm trong file module
ADD module.sh ${module}/
RUN chmod a+x ${module}/module.sh
# CMD ["sleep", "30s"] 
# tệp user chỉ khóa người dùng và token api
ADD user.sh /etc/cont-init.d/
RUN chmod a+x /etc/cont-init.d/user.sh
# cập nhật gói khi hoàn tất images
RUN apt-get update -y