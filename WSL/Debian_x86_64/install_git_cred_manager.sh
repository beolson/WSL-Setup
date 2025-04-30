#!/bin/bash -i

echo '******************* install Git Credential Manager starting'
apt install -y git wget libicu-dev

sudo apt install -y gnupg2 apt-transport-https
wget -O - https://pkg.wslutiliti.es/public.key | sudo gpg -o /usr/share/keyrings/wslu-archive-keyring.pgp --dearmor

echo "deb [signed-by=/usr/share/keyrings/wslu-archive-keyring.pgp] https://pkg.wslutiliti.es/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") main" | sudo tee /etc/apt/sources.list.d/wslu.list

sudo apt update
sudo apt install -y wslu

readonly GIT_CREDENTIAL_MANAGER_URL='https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.5.0/gcm-linux_amd64.2.5.0.deb';
readonly GIT_CREDENTIAL_MANAGER_CHECKSUM='d50ed45408fc76ae82bced4025514987f8c8e9e7c2ab9f4bf57ccbc854d68b3e  gcm.deb'

wget $GIT_CREDENTIAL_MANAGER_URL -O gcm.deb
if ! echo $GIT_CREDENTIAL_MANAGER_CHECKSUM | sha256sum --check -; then
    echo "Git Credential Manager Checksum failed" >&2
    exit 1
fi
sudo apt install ./gcm.deb
rm ./gcm.deb


echo '******************* install Git Credential Manager completed'
