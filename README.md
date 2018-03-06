# nginx-proxy

This repository contains a **Dockerfile** for Nginx configured as an HTTP/HTTPS cache.

## Base Docker image

 - [Alpine Linux](https://hub.docker.com/_/alpine/)

## Usage

No SSL:

```
docker build -t nginx-proxy .
docker run -d -p 80:80 nginx-proxy
```

Dummy SSL:

```
./build_dummy_ssl.sh
docker run -d -p 80:80 -p 443:443 nginx-proxy
```

Real SSL certificate:

```
docker build -t nginx-proxy .
docker run -d -p 80:80 -p 443:443 -v <path_to_cert>:/certs -e SSL_CERT=/certs/cert.crt -e SSL_KEY=/certs/cert.key nginx-proxy
```

No IPv6 available on the host but it is on the server. It is not optimal, but here is a workaround:

```
docker run -d -p 80:80 -e REMOTE_HOST=ftp.fr.debian.org -e REMOTE_IP=212.27.32.66 nginx-proxy
```

## Parameters

### Variables

 - `REMOTE_PROTOCOLE`: http or https (default=https)
 - `REMOTE_HOST`: distant website to cache (default=www.example.com)
 - `REMOTE_IP`: real IP (for instance to override the IP for a given DNS)
 - `KEY_ZONE_SIZE`: parameter for the number of keys in the cache (default=10m so ~80k keys)
 - `TTL`: cache validity (default=1d)
 - `SSL_CERT`: SSL certificate (default=/opt/cert.crt for the dummy one)
 - `SSL_KEY`: SSL key (default=/opt/cert.key for the dummy one)
 - `MAX_SIZE`: max cache size (default=10g)

### Volumes

 - `/var/cache/nginx`: where the files are put
