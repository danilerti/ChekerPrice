FROM alpine:latest

RUN apk add --no-cache ca-certificates curl

RUN mkdir -p /usr/bin/xray && \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin/xray && \
    chmod +x /usr/bin/xray/xray && \
    rm /tmp/xray.zip

RUN addgroup -S xraygroup && adduser -S xrayuser -u 10014 -G xraygroup
RUN mkdir -p /etc/xray && chown -R xrayuser:xraygroup /etc/xray

USER 10014

# Настройка gRPC на порту 8080
RUN echo '{\
  "inbounds": [{\
    "port": 8080,\
    "protocol": "vless",\
    "settings": {\
      "clients": [{"id": "306752e1-2c7e-4300-a874-dd4dfb900786"}],\
      "decryption": "none"\
    },\
    "streamSettings": {\
      "network": "grpc",\
      "grpcSettings": {\
        "serviceName": "grpc-proxy"\
      }\
    }\
  }],\
  "outbounds": [{"protocol": "freedom"}]\
}' > /etc/xray/config.json

CMD ["/usr/bin/xray/xray", "-config", "/etc/xray/config.json"]
