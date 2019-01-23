#!/usr/bin/env bash

pcs cluster cib fs_cfg

pcs -f fs_cfg resource create \
    DRBDFS Filesystem device="/dev/drbd0" directory="/var/www/html" fstype="ext4"

pcs -f fs_cfg constraint colocation add FloatingIPAddress with DRBDFS INFINITY
pcs -f fs_cfg constraint order DRBDFS then FloatingIPAddress

pcs cluster cib-push fs_cfg

pcs resource op defaults timeout=10s
