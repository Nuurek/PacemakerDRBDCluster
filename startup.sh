#!/usr/bin/env bash

sed -i "s/^SELINUX=.*/SELINUX=permissive/g" /etc/selinux/config
setenforce 0

systemctl enable pcsd
systemctl enable corosync
systemctl enable pacemaker

systemctl start pcsd
systemctl start corosync
systemctl start pacemaker

drbdadm create-md d0
drbdadm down d0
drbdadm up d0
