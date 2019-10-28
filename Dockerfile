FROM alpine:edge

ENV DNSCRYPT_LISTEN_PORT=5053 \
    DNSCRYPT_SERVER_NAMES="" \
	PUID=1000 \
	PGID=100

COPY entrypoint.sh /

RUN apk add --no-cache dnscrypt-proxy drill \
	&& chmod +x /entrypoint.sh

HEALTHCHECK --interval=5s --timeout=3s --start-period=10s \
	CMD drill -p $DNSCRYPT_LISTEN_PORT cloudflare.com @127.0.0.1 || exit 1

ENTRYPOINT ["/entrypoint.sh"]
