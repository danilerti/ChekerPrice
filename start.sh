#!/bin/sh
# Копируем конфиг
cp /etc/xray/config.json /tmp/config.json

# ВАЖНО: Если в оригинальном config.json уже стоит 8080, 
# просто удали все строки с sed, чтобы ничего не испортить.
# Если там 10000, используй это:
sed -i 's/10000/8080/g' /tmp/config.json

/usr/bin/xray/xray -config /tmp/config.json
