#!/bin/bash -i

nvm install v20.14.0 
pnpm config set cafile /etc/ssl/certs/ca-certificates.crt -g
pnpm install @devcontainers/cli -g


echo '********************************************'
echo '********************************************'
echo '****************Setup Complete**************'
echo '********************************************'
echo '********************************************'

exit