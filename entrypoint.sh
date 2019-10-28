#!/bin/sh

# https://gist.github.com/qizhihere/c8db099c673e2f4718418ca05c9b2767
has_gid () {
    cut -d: -f1,4 /etc/passwd | grep -q "^${1}:${2}" || return 1
}

# example: ensure_user btsync 1000 1000
ensure_user () {
    local user=$1
    local uid=$2
    local gid=$3
    local group_prefix=${4:-_}

    {
        deluser $user
        delgroup $user
        delgroup $group_prefix$user
    } 2>/dev/null

    adduser -h / -s /bin/sh -D -u $uid $user
    has_gid $user $gid || {
        addgroup -g $gid $group_prefix$user
        sed -i 's/^\('$user'\(:[^:]\{1,\}\)\{2\}\):[0-9]\{1,\}/\1:'$gid/ /etc/passwd
    }

}

if [ ! -f /config/dnscrypt-proxy.toml ]
then
    chown $PUID /usr/share/dnscrypt-proxy/
    CONFIG=/usr/share/dnscrypt-proxy/example-dnscrypt-proxy.toml
else
    chown $PUID /config 
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

ensure_user dnscryptproxy $PUID $PGID

echo "dnscrypt-proxy -config $CONFIG $@"
exec su dnscryptproxy -c "dnscrypt-proxy -config $CONFIG $@"
