#!/bin/bash -i
sudo apt update
sudo apt upgrade -y

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

{
    echo "export PRIVATE_CERTS_FILE=/etc/ssl/certs/ca-certificates.crt"
} >> /etc/profile.d/certs.sh

echo '******************* configure ca certs complete'

echo '******************* Configure Git'


sudo apt install -y git wget

sudo mkdir -p -m 755 /etc/apt/keyrings
out=$(mktemp)
wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg
cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt install gh -y



echo '******************* upgrade complete'
