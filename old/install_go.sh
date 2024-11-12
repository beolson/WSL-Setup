#!/bin/bash -i

echo '******************* install Go starting'

wget https://go.dev/dl/go1.23.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.23.3.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin
echo 'PATH=$PATH:/usr/local/go/bin' >>~/.profile

rm go1.23.3.linux-amd64.tar.gz

echo '******************* install Go completed'