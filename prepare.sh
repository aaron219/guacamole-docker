#!/bin/sh

echo "Create a guacamole working directory"
# create a working directory for guacamole
# include configure, extensions, init sql, ssl cert and ssl key
# >/dev/null 2>&1 mean that skip output (eg. error output)
mkdir -p ./guacamole-data/initsql >/dev/null 2>&1 && mkdir -p ./guacamole-data/nginx/ssl >/dev/null 2>&1
chmod -R +x ./guacamole-data/initsql
mkdir -p ./guacamole-data/extensions >/dev/null 2>&1 && mkdir -p ./guacamole-data/configurefile >/dev/null 2>&1
echo "done"
echo "=========================================="

# OPTION #
echo "Copy OTP and custom login page extension configure and source file to working directory"
cp ./guacamole-pre-file/extensions/* ./guacamole-data/extensions
cp ./guacamole-pre-file/configurefile/* ./guacamole-data
echo "done"
echo "=========================================="

echo "Copy default nginx file to guacamole working directory"
cp ./nginx-default-configure/nginx.conf ./guacamole-data/nginx/
cp ./nginx-default-configure/mysite ./guacamole-data/nginx
echo "done"
echo "=========================================="

echo "Create 'initdb.sql' file for init Database"
# run initdb.sh script to generate initdb.sql file in contianer guacamole
# once finish generate, auto remove this container and it's volume
# generate the sql file for mysql or mariadb
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > ./guacamole-data/initsql/initdb.sql
echo "done"
echo "=========================================="

echo "Create SSL Cert"
# create a cert and private key
# -nodes = no des
# -newkey = create a private key use rsa 2048
# -new = create a cert use x509
# -keyout = set private key output location and name
# -out = set cert output location and name
# -subj = set info of the cert
openssl req -nodes -newkey rsa:2048 -new -x509 -keyout self-ssl.key -out self.crt -subj '/C=MO/ST=Macau/L=Macau/O=Local-test/OU=IT/CN=www.local-test.it/emailAddress=user@local-test.it'
mv ./self* ./guacamole-data/nginx/ssl
echo "done"
echo "=========================================="
