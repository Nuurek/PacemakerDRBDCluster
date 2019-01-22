#! /bin/sh

service corosync start
sleep 10
corosync-cmapctl | grep members
service pacemaker start
crm_mon
