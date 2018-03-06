FROM alpine
LABEL maintainer="alexandre@blazart.fr"

RUN apk add --no-cache nginx \
    && rm -rf /usr/lib/perl5 \
              /etc/nginx/conf.d/* \
              /etc/ssl/openssl.cnf \
              /etc/init.d/nginx \
              /etc/logrotate.d/nginx
COPY rootfs/ /
ENV REMOTE_PROTOCOLE=https \
    REMOTE_HOST=www.example.com \
    REMOTE_IP= \
    KEYS_ZONE_SIZE=10m \
    TTL=1d \
    SSL_CERT=/opt/cert.crt \
    SSL_KEY=/opt/cert.key \
    MAX_SIZE=10g
EXPOSE 80/tcp 443/tcp
VOLUME ["/var/cache/nginx"]
CMD ["/opt/run.sh"]

