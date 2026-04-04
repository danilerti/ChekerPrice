FROM alpine:latest

# Устанавливаем необходимые пакеты
RUN apk add --no-cache ca-certificates curl

# Создаем пользователя заранее (Checkov Fix)
RUN addgroup -S xraygroup && adduser -S xrayuser -u 10014 -G xraygroup

# Скачиваем и устанавливаем Xray
RUN mkdir -p /usr/bin/xray && \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin/xray && \
    chmod +x /usr/bin/xray/xray && \
    rm /tmp/xray.zip

COPY config.json /etc/xray/config.json
COPY start.sh /start.sh

# Настраиваем права
RUN chmod +x /start.sh && \
    chown -R xrayuser:xraygroup /etc/xray && \
    chown xrayuser:xraygroup /start.sh && \
    chown xrayuser:xraygroup /usr/bin/xray/xray

USER 10014

CMD ["/bin/sh", "/start.sh"]
