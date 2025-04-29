#!/bin/bash -i

echo '******************* configure ca certs starting'

CERTS="../certs/*"

for f in $CERTS
do
    echo "copying $f into cert store"
    chmod 0655 $f
    cp $f /usr/local/share/ca-certificates/
done
/usr/sbin/update-ca-certificates

echo '******************* configure ca certs complete'
