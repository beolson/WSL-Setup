#!/bin/bash -i

echo '******************* install Dot Net starting'

sudo apt install -y ca-certificates libc6 libgcc-s1 libgssapi-krb5-2 libicu74 liblttng-ust1 libssl3 libstdc++6 libunwind8 zlib1g

wget https://download.visualstudio.microsoft.com/download/pr/ca6cd525-677e-4d3a-b66c-11348a6f920a/ec395f498f89d0ca4d67d903892af82d/dotnet-sdk-8.0.403-linux-x64.tar.gz
sudo mkdir -p /usr/local/dotnet && sudo tar zxf dotnet-sdk-8.0.403-linux-x64.tar.gz -C /usr/local/dotnet
export DOTNET_ROOT=/usr/local/dotnet
export PATH=$PATH:/usr/local/dotnet

echo 'DOTNET_ROOT=/usr/local/dotnet' >>~/.profile
echo 'PATH=$PATH:/usr/local/dotnet' >>~/.profile

rm dotnet-sdk-8.0.403-linux-x64.tar.gz

echo '******************* install Dot Net completed'