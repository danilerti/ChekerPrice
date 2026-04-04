#!/bin/sh

# Просто запускаем Xray, так как конфиг уже правильный
# Мы используем путь /etc/xray/config.json, так как нам больше не нужно ничего править через sed
/usr/bin/xray/xray -config /etc/xray/config.json
