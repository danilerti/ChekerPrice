FROM ghcr.io/xtls/xray-core:latest

# Создаем группу и пользователя для безопасности (Checkov Fix)
RUN addgroup -S xraygroup && adduser -S xrayuser -u 10014 -G xraygroup

COPY config.json /etc/xray/config.json
COPY start.sh /start.sh

# Даем права пользователю на нужные файлы
RUN chmod +x /start.sh && \
    chown -R xrayuser:xraygroup /etc/xray && \
    chown xrayuser:xraygroup /start.sh

# Переключаемся на непривилегированного пользователя
USER 10014

CMD ["/bin/sh", "/start.sh"]
