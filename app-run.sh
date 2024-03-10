#!/bin/bash

# postconf
echo ">> Running postconf"
postconf -e "myhostname=$HOSTNAME"
postconf -e "mydomain=$DOMAINNAME"
postconf -e "smtpd_tls_cert_file=/etc/ssl/cert/fullchain.pem"
postconf -e "smtpd_tls_key_file=/etc/ssl/cert/privkey.pem"
postconf -e "myorigin=\$mydomain"
postconf -e "inet_interfaces=all"
postconf -e "inet_protocols=ipv4"
postconf -e "mydestination=mail.\$mydomain"
postconf -e "mynetworks=127.0.0.1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
postconf -e "smtpd_tls_loglevel=1"
postconf -e "smtputf8_enable=yes"
postconf -e "milter_default_action = accept"
postconf -e "milter_protocol = 6"
postconf -e "smtpd_milters = local:opendkim/opendkim.sock"
postconf -e "non_smtpd_milters = \$smtpd_milters"
postconf -e "maillog_file=/var/log/mail/mail.log"

# opendkin owner
chown -R opendkim:opendkim /etc/opendkim
chmod -R 0700 /etc/opendkim/keys

# starting services
echo ">> starting the services"
service opendkim start
service postfix start

# print logs
echo ">> printing the logs"
tail -F /var/log/mail.log

