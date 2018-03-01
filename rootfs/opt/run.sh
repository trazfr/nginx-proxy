#!/bin/sh

if [ ! -f "$SSL_CERT" ] || [ ! -f "$SSL_KEY" ]
then
	MISC_SED='/HTTPS_BEGIN/,/HTTPS_END/d'
        echo "SSL disabled"
else
        cp "$SSL_CERT" /etc/ssl/certs/cert.crt
        cp "$SSL_KEY" /etc/ssl/certs/cert.key
fi

for template in $(dirname -- "$0")/*.tmpl
do
	conf=$(echo $template | sed 's/\.tmpl$//')
	sed "s|@REMOTE_PROTOCOLE@|$REMOTE_PROTOCOLE|g;
		s|@REMOTE_HOST@|$REMOTE_HOST|g;
		s|@TTL@|$TTL|g;
		s|@MAX_SIZE@|$MAX_SIZE|g;
		s|@KEYS_ZONE_SIZE@|$KEYS_ZONE_SIZE|g;
		$MISC_SED" \
		"$template" \
		>| "/etc/nginx/conf.d/$(basename -- "$conf")"
done

mkdir /run/nginx
/usr/sbin/nginx -g 'daemon off;'
