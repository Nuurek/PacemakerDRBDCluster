FROM ubuntu:bionic

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y net-tools iproute2 iputils-ping apache2 pacemaker crmsh

ADD corosync.conf /etc/corosync

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]