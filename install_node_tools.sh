#!/bin/bash -i

echo '******************* install Node starting'

sudo wget  https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
sudo wget  https://get.pnpm.io/install.sh | sh -


nvm install v20.14.0 
pnpm config set cafile /etc/ssl/certs/ca-certificates.crt -g
pnpm install @devcontainers/cli -g

echo '******************* install Node completed'