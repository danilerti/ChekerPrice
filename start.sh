#!/bin/sh

# 1. Копируем конфиг во временную директорию (разрешена запись)
cp /etc/xray/config.json /tmp/config.json

# 2. Правим порт. 
# Эта команда найдет строку "port": XXXX и заменит число на 8080
sed -i 's/"port": [0-9]*/"port": 8080/' /tmp/config.json

# 3. Запускаем Xray, указывая на исправленный конфиг
/usr/bin/xray/xray -config /tmp/config.json
