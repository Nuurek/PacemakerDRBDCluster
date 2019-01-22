#! /bin/sh

corosync
sleep 1
corosync-cmapctl | grep members

/usr/sbin/pacemakerd &
pcs property set stonith-enabled=false
pcs property set no-quorum-policy=ignore
pcs resource create FloatingIP IPaddr2 ip=172.16.0.150

/usr/sbin/httpd

cp /hosts /etc/hosts
sleep 1
/usr/sbin/sshd

tail -f /var/log/httpd/access_log
