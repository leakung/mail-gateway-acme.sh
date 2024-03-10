#!/bin/bash
docker run --rm -it -v ./acme.sh:/acme.sh -v ./etc-ssl-cert:/etc/ssl/cert neilpang/acme.sh --install-cert -d domain.tld --key-file /etc/ssl/cert/privkey.pem --fullchain-file /etc/ssl/cert/fullchain.pem
