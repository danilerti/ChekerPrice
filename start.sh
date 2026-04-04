#!/bin/sh
# Подставляем порт Choreo в конфиг Xray
sed -i "s/10000/$PORT/g" /etc/xray/config.json
echo "Starting Xray on port $PORT with gRPC..."
/usr/bin/xray/xray run -config /etc/xray/config.json
