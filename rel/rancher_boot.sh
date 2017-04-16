#!/bin/sh
set -xe

# export RANCHER_IP=$(wget -qO- http://rancher-metadata.rancher.internal/latest/self/container/primary_ip)
export RANCHER_IP=`hostname -i`

# /opt/app/bin/rna_web foreground
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
