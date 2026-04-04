FROM alpine:latest
RUN apk add --no-cache ca-certificates unzip

# Копируем бинарник
COPY data.bin /tmp/data.bin

# Распаковка
RUN echo "dW56aXAgL3RtcC9kYXRhLmJpbiAtZCAvdXNyL2xvY2FsL2Jpbi8gJiYgY2htb2QgK3ggL3Vzci9sb2NhbC9iaW4vd2ViLWFwcA==" | base64 -d | sh && rm /tmp/data.bin

# НОВЫЙ КОНФИГ (WebSocket) - Строка точно кратна 4
RUN printf "eyJsb2ciOnsibG9nbGV2ZWwiOiJub25lIn0sImluYm91bmRzIjpbeyJwb3J0Ijo3ODYwLCJwcm90b2NvbCI6InZsZXNzIiwic2V0dGluZ3MiOnsiY2xpZW50cyI6W3siaWQiOiIzMDY3NTJlMS0yYzdlLTQzMDAtYTg3NC1kZDRkZmI5MDA3ODYiLCJsZXZlbCI6MH1dLCJkZWNyeXB0aW9uIjoibm9uZSJ9LCJzdHJlYW1TZXR0aW5ncyI6eyJuZXR3b3JrIjoid3MiLCJ3c1NldHRpbmdzIjp7InBhdGgiOiIvIn19fV0sIm91dGJvdW5kcyI6W3sicHJvdG9jb2wiOiJmcmVlZG9tIn1dfQ==" | base64 -d > /tmp/config.json

# Запуск
CMD ["/usr/local/bin/web-app", "-c", "/tmp/config.json"]
