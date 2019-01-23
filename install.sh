#!/usr/bin/env bash

rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

yum -y install \
    pacemaker \
    pcs \
    resource-agents \
    httpd \
    php \
    drbd90-utils \
    kmod-drbd90

echo CHANGEME | passwd --stdin hacluster

(cat > /etc/hosts) <<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.10.11   n1
192.168.10.12   n2
192.168.10.13   n3
EOF

cp /vagrant/corosync.conf /etc/corosync/corosync.conf

cp /vagrant/d0.res /etc/drbd.d/d0.res

cp /vagrant/httpd.conf /etc/httpd/conf/httpd.conf