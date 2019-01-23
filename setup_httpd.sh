#!/usr/bin/env bash

pcs resource create \
    FloatingIPAddress IPaddr2 ip=192.168.10.10 cidr_netmask=24 \
    op monitor interval=1s

pcs resource create \
    Apache ocf:heartbeat:apache \
    configfile=/etc/httpd/conf/httpd.conf \
    statusurl="http://127.0.0.1/server-status" \
    op monitor interval=20s

pcs constraint colocation add Apache FloatingIPAddress INFINITY
pcs constraint order FloatingIPAddress then Apache
