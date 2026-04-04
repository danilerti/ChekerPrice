#!/bin/sh

export PORT=${PORT:-10000}

sed -i "s/10000/$PORT/g" /etc/xray/config.json

/usr/local/bin/xray -config /etc/xray/config.json
