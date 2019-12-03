FROM arm32v7/alpine:edge

COPY --from=balenalib/raspberrypi3-alpine /usr/bin/qemu-arm-static /usr/bin/qemu-arm-static
COPY --from=balenalib/raspberrypi3-alpine /usr/bin/resin-xbuild /usr/bin/resin-xbuild
COPY --from=balenalib/raspberrypi3-alpine /usr/bin/cross-build-start /usr/bin/cross-build-start
COPY --from=balenalib/raspberrypi3-alpine /usr/bin/cross-build-end /usr/bin/cross-build-end

RUN [ "cross-build-start" ]

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

RUN [ "cross-build-end" ]