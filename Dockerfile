FROM alpine:latest

# Устанавливаем зависимости
RUN apk add --no-cache ca-certificates curl

# Скачиваем последнюю версию Xray
RUN mkdir -p /usr/bin/xray && \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin/xray && \
    chmod +x /usr/bin/xray/xray && \
    rm /tmp/xray.zip

# Создаем конфиг (VLESS + WebSocket)
# Choreo слушает порт 8080 по умолчанию
RUN echo '{\
  "inbounds": [{\
    "port": 8080,\
    "protocol": "vless",\
    "settings": {\
      "clients": [{"id": "306752e1-2c7e-4300-a874-dd4dfb900786"}],\
      "decryption": "none"\
    },\
    "streamSettings": {\
      "network": "ws",\
      "wsSettings": {"path": "/"}\
    }\
  }],\
  "outbounds": [{"protocol": "freedom"}]\
}' > /etc/xray.json

# Запуск
CMD ["/usr/bin/xray/xray", "-config", "/etc/xray.json"]
