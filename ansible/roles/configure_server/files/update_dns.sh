#!/bin/bash
sed -i '/search/c\search abc.com  xyz.net' /etc/resolv.conf
umount /var/lib/nfs/rpc_pipefs
mount -t rpc_pipefs -o rw,relatime,nodev  sunrpc /var/lib/nfs/rpc_pipefs
