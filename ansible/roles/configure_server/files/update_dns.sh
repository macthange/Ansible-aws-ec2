#!/bin/bash
sed -i '/search/c\search avivaaws.com avivagroup.com via.novanet' /etc/resolv.conf
umount /var/lib/nfs/rpc_pipefs
mount -t rpc_pipefs -o rw,relatime,nodev  sunrpc /var/lib/nfs/rpc_pipefs
