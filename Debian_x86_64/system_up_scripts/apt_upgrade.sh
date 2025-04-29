#!/bin/bash -i

echo '******************* upgrade starting'

sudo apt update
sudo apt upgrade -y

# apt install -y ca-certificates libc6 libgcc-s1 libgssapi-krb5-2 libicu74 liblttng-ust1 libssl3 libstdc++6 libunwind8 zlib1g
# # install tools to support WSL, and DotFiles management
# apt install -y wslu xdg-utils stow


echo '******************* upgrade complete'
