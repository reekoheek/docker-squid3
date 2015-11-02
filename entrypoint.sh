#!/bin/bash
set -e

cp /tmp/squid.conf /etc/squid3/squid.conf

usermod -u 1000 proxy
groupmod -g 1000 proxy
chown -R proxy:proxy /var/log/squid3 /var/cache/squid3


if [[ ! -d /var/cache/squid3/00 ]]; then
  echo "Initializing cache..."
  squid3 -N -f /etc/squid3/squid.conf -f /etc/squid3/squid.conf -z
fi

exec "$@"