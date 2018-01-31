#!/bin/ash

chown -R mosquitto /run/mosquitto /var/lib/mosquitto/data /var/log/mosquitto
set -e
exec "$@"
