#!/bin/sh
export PORT=${PORT:-10000}
sed -i "s/10000/$PORT/g" /etc/xray/config.json
/usr/bin/xray/xray run -config /etc/xray/config.json
