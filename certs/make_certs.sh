#!/bin/bash

set -e

rm ca* 2> /dev/null || true
rm *.pem 2> /dev/null || true

cat > ca.conf <<EOF
[ ca ]
default_ca = ca_default

[ ca_default ]
dir = ./
certs = \$dir
new_certs_dir = \$dir
database = ca-db-index
serial = ca-db-serial
RANDFILE = ca-db-rand
certificate = ca-cert.pem
private_key = ca-key.pem
default_days = 1825
default_crl_days = 365
default_md = sha512
preserve = no
policy = generic_policy

[ generic_policy ]
countryName = optional
stateOrProvinceName = optional
localityName = optional
organizationName = optional
organizationalUnitName = optional
commonName = supplied
emailAddress = optional
EOF

echo 01 > ca-db-serial
touch ca-db-index

openssl req -newkey rsa:4096 -x509 -nodes -out ca-cert.pem -keyout ca-key.pem -days 1825 -sha512 <<EOF
.
.
.
Root CA
.
*
.
EOF

openssl req -nodes -new -newkey rsa:4096 -keyout server-key.pem -out server.csr -days 1825 -sha512 <<EOF
.
.
.
Flask Rest Target
.
flask_target
.


EOF

openssl ca -config ca.conf -days 1825 -in server.csr -out server-cert.pem -batch

rm server.csr

openssl req -nodes -new -newkey rsa:4096 -keyout client-key.pem -out client.csr -days 1825 -sha512 <<EOF
.
.
.
Client User
.
user
.


EOF

openssl ca -config ca.conf -days 1825 -in client.csr -out client-cert.pem -batch

rm client.csr
