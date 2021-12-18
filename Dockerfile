# xây dừng từ bản có sẵn
ARG CODE_VERSION=latest
FROM tiredofit/freepbx:${CODE_VERSION}
LABEL maintainer="hacker@gmail.com"
# bien moi truong asterisk 
ENV ASTERISKUSER asterisk
# thu muc chinh                 
WORKDIR "/root/"

# cap nhat goi
RUN ["apt-get", "update", "-y"]
RUN mkdir -p /root/admin
COPY mode/module.sh /root/admin
COPY mode/user.sh /root/admin
COPY mode/tools.sh /root/admin
# /---------------------------------MYSQL--------------------------------\
# |======================================================================|
COPY mysql/userLogin.sql /docker-entrypoint-initdb.d/

USER root

ADD start.sh /etc/cont-init.d/
RUN chmod u+x /etc/cont-init.d/start.sh

EXPOSE 8080