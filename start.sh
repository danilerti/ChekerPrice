#!/bin/sh

# Просто запускаем Xray, указывая на файл конфигурации.
# Мы не трогаем файл через sed, чтобы не сломать структуру JSON.
/usr/bin/xray/xray -config /etc/xray/config.json
