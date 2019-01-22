FROM ubuntu:bionic

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y net-tools iproute2 iputils-ping apache2 pacemaker crmsh drbd8-utils ssh

ADD corosync.conf /etc/corosync

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

COPY ./hosts /

RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P "" && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && echo "StrictHostKeyChecking no" >> ~/.ssh/config

ENTRYPOINT [ "/entrypoint.sh" ]