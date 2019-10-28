#!/bin/sh

if [ ! -f /config/dnscrypt-proxy.toml ]
then
    CONFIG=/usr/share/dnscrypt-proxy/example-dnscrypt-proxy.toml
else
    CONFIG=/config/dnscrypt-proxy.toml
fi

if [ -n "${DNSCRYPT_LISTEN_PORT}" ]
then
    sed -r "s/^(# )?(listen_addresses = ).+$/\2['0.0.0.0:${DNSCRYPT_LISTEN_PORT}']/" -i $CONFIG
fi

if [ -n "${DNSCRYPT_SERVER_NAMES}" ]
then
    sed -r "s/^(# )?(server_names = ).+$/\2${DNSCRYPT_SERVER_NAMES}/" -i $CONFIG
fi

echo "dnscrypt-proxy -config $CONFIG $@"
exec su-exec 1001 dnscrypt-proxy -config $CONFIG $@

