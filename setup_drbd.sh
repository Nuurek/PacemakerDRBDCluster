#!/usr/bin/env bash

drbdadm --force primary d0
mkfs.ext4 /dev/drbd0

mount /dev/drbd0 /mnt
cp /vagrant/editor.php /mnt/index.php
chmod -R 777 /mnt
umount /mnt

drbdadm secondary d0
