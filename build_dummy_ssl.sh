#!/bin/sh

cd "$(dirname -- "$0")"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout rootfs/opt/cert.key -out rootfs/opt/cert.crt
docker build -t $(basename -- "$PWD") .

