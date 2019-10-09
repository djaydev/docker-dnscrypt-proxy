FROM alpine:edge

COPY entrypoint.sh /

RUN apk add --no-cache dnscrypt-proxy drill \
	&& chmod +x /entrypoint.sh

ENV DNSCRYPT_LISTEN_PORT=5053 \
    DNSCRYPT_SERVER_NAMES=""

HEALTHCHECK --interval=5s --timeout=3s --start-period=10s \
	CMD drill -p $DNSCRYPT_LISTEN_PORT cloudflare.com @127.0.0.1 || exit 1

ENTRYPOINT ["/entrypoint.sh"]
