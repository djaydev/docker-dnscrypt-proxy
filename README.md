# No Longer Maintained

## Great Alternatives

## <https://registry.hub.docker.com/r/gists/dnscrypt-proxy>

## <https://registry.hub.docker.com/r/klutchell/dnscrypt-proxy>

DNSCrypt-Proxy on Alpine Linux

[dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy) is a flexible DNS proxy, with support for encrypted DNS protocols.

**x86/x64 AMD64:**
`djaydev/dnscrypt-proxy:latest`

**ARM32v7 RaspberryPi:**
`djaydev/dnscrypt-proxy:arm32v7`

Example run

```shell
    docker run -d \
    --name=dnscrypt-proxy \
    --net=host \
    -e DNSCRYPT_LISTEN_PORT=53 \
    -e DNSCRYPT_SERVER_NAMES="['scaleway-fr','google','yandex','cloudflare']" \
    djaydev/dnscrypt-proxy
```

Where:

- `DNSCRYPT_LISTEN_PORT`: Port DNSCrypt-Proxy will listen on.
- `DNSCRYPT_SERVER_NAMES`: DNS over HTTPS servers you want to use. [public resolvers](https://download.dnscrypt.info/dnscrypt-resolvers/v2/public-resolvers.md)
- `PUID`: ID of the user the application runs as. -OPTIONAL
- `PGID`: ID of the group the application runs as. -OPTIONAL

## Mount a custom configuration directory

```shell
    docker run -d \
    --name=dnscrypt-proxy \
    --net=host \
    -e DNSCRYPT_LISTEN_PORT=53 \
    -e DNSCRYPT_SERVER_NAMES="['scaleway-fr','google','yandex','cloudflare']" \
    -v /path/to/config/dnscrypt-proxy.toml:/config/dnscrypt-proxy.toml \
    djaydev/dnscrypt-proxy
```

Official project wiki: www.github.com/DNSCrypt/dnscrypt-proxy/wiki

## Credits

Original software is by the DNSCrypt project: www.dnscrypt.info
