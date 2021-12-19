# xây dừng từ bản có sẵn
ARG CODE_VERSION=latest
# /---------------------------------FreePBX--------------------------------\
FROM tiredofit/freepbx:${CODE_VERSION}
LABEL maintainer="companydatv@gmail.com"
# bien moi truong asterisk 
ENV ASTERISKUSER asterisk
# thu muc chinh                 
WORKDIR "/root/"
# cap nhat goi
RUN ["apt-get", "update", "-y"]
RUN mkdir -p /root/admin
# /---------------------------------Copy Folder--------------------------------\
COPY mode/module.sh /root/admin
COPY mode/api.sh /root/admin
COPY mode/tools.sh /root/admin
# /---------------------------------MYSQL--------------------------------\
# |======================================================================|
# COPY mysql/userLogin.sql /docker-entrypoint-initdb.d/

USER root
# /---------------------------------RUN Scripts--------------------------------\
ADD start.sh /etc/cont-init.d/
RUN chmod u+x /etc/cont-init.d/start.sh
# /---------------------------------PORT--------------------------------\
EXPOSE 8080