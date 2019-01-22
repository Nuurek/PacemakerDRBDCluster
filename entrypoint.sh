#! /bin/sh

service corosync start
sleep 2
corosync-cmapctl | grep members

service pacemaker start
crm configure property stonith-enabled=false
crm configure property no-quorum-policy=ignore
crm configure primitive FloatingIPAddress ocf:heartbeat:IPaddr2 params ip=172.16.0.150 op monitor interval=1s

service apache2 start

cp /hosts /etc/hosts
service ssh start

tail -f /var/log/apache2/access.log
