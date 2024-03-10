#!/bin/bash
docker run --rm -it -v ./acme.sh:/acme.sh -v ./etc-nginx-cert:/etc/nginx/cert neilpang/acme.sh --cron
