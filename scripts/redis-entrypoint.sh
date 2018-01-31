#!/bin/sh
if [[ "$1" == "redis-server" ]]; then
  mkdir -p /run/redis
  chmod g+s /run/redis
  chown -R redis /run/redis /var/lib/redis/data
  exec gosu redis "$@"
fi
exec "$@"
