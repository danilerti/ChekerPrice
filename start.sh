#!/bin/sh

# 1. Копируем конфиг туда, где разрешено изменять файлы
cp /etc/xray/config.json /tmp/config.json

# 2. Правим порт и UUID во временном файле (если используешь sed)
# Если тебе нужно просто заменить порт на 8080:
sed -i "s/8080/g" /tmp/config.json

# 3. Запускаем Xray, указывая на новый путь к конфигу
/usr/bin/xray/xray -config /tmp/config.json
