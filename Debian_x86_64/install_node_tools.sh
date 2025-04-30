#!/bin/bash -i

echo '******************* install Node starting'

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
wget -qO- https://get.pnpm.io/install.sh | sh -

echo '******************* install Node completed'
