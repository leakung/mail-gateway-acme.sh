#!/bin/bash
docker run --rm -it -e CF_Token="xxx" -v ./acme.sh:/acme.sh neilpang/acme.sh --issue --server letsencrypt -k ec-256 --dns dns_cf --challenge-alias alias-domain.tld -d domain.tld 
