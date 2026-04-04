FROM alpine:latest

# Устанавливаем необходимые пакеты
RUN apk add --no-cache ca-certificates curl unzip

# Создаем группу и пользователя с фиксированным ID (как требует Choreo)
RUN addgroup -S xraygroup && adduser -S xrayuser -u 10014 -G xraygroup

# Скачиваем и устанавливаем Xray
RUN mkdir -p /usr/bin/xray /etc/xray /tmp/xray_logs && \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin/xray && \
    chmod +x /usr/bin/xray/xray && \
    rm /tmp/xray.zip

# Копируем конфиг и скрипт
COPY config.json /etc/xray/config.json
COPY start.sh /start.sh

# НАСТРОЙКА ПРАВ (Критически важно для Choreo)
RUN chmod +x /start.sh && \
    # Даем права на чтение конфига
    chown -R xrayuser:xraygroup /etc/xray && \
    # Разрешаем запись в /tmp (там будет лежать рабочий конфиг)
    chmod 777 /tmp && \
    chown xrayuser:xraygroup /start.sh && \
    chown xrayuser:xraygroup /usr/bin/xray/xray

# Переключаемся на пользователя Choreo
USER 10014

# Запускаем через наш скрипт
CMD ["/bin/sh", "/start.sh"]
