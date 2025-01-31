#!/bin/bash -i

echo '******************* install Git Credential Manager starting'


if [[ "$ARCH" == "x86_64" ]]; then
    readonly GIT_CREDENTIAL_MANAGER_URL='https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.5.0/gcm-linux_amd64.2.5.0.deb';
    readonly GIT_CREDENTIAL_MANAGER_CHECKSUM='d50ed45408fc76ae82bced4025514987f8c8e9e7c2ab9f4bf57ccbc854d68b3e  gcm.deb'
elif [[ "$ARCH" == "arm"* ]]; then
    readonly GIT_CREDENTIAL_MANAGER_URL='https://github.com/beolson/git-credential-manager/releases/download/ARM2/gcm-linux-arm64.2.6.1.deb';
    readonly GIT_CREDENTIAL_MANAGER_CHECKSUM='ab91cb2dd6e956f5fd74f1c652f03ad69b9bd454dc7264ccb32ef7ec423368b5  gcm.deb'
else
    echo 
    return "Unsupported architecture: $ARCH" 2>/dev/null || exit "Unsupported architecture: $ARCH"
fi


wget $GIT_CREDENTIAL_MANAGER_URL -O gcm.deb
if ! echo $GIT_CREDENTIAL_MANAGER_CHECKSUM | sha256sum --check -; then
    echo "Git Credential Manager Checksum failed" >&2
    exit 1
fi
sudo apt install ./gcm.deb
rm ./gcm.deb


echo '******************* install Git Credential Manager completed'