# FROM ubuntu:bionic
FROM centos

# RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y net-tools iproute2 iputils-ping apache2 pacemaker crmsh drbd8-utils ssh
RUN yum install -y pacemaker pcs iproute which httpd openssh-server openssh-clients

ADD corosync.conf /etc/corosync

COPY ./hosts /

ADD sshd_config /etc/ssh/sshd_config
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -P "" && cat /etc/ssh/ssh_host_rsa_key.pub >> /etc/ssh/authorized_keys && mkdir ~/.ssh && cp /etc/ssh/ssh_host_rsa_key ~/.ssh/id_rsa
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
ADD drbd.conf /etc

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]