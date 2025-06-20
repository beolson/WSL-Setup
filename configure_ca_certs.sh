#!/bin/bash -i

echo '******************* configure ca certs starting'
apt-get -y install ca-certificates
CERTS="./certs/*"
mkdir /usr/local/share/ca-certificates/
for f in $CERTS
do
    echo "copying $f into cert store"
    chmod 0655 $f
    cp $f /usr/local/share/ca-certificates/
done
/usr/sbin/update-ca-certificates

echo '******************* configure ca certs complete'
