#!/bin/bash -i

echo '******************* copy gitconfig'


cp -r ./gitconfig/. ~/

if [[ ! -v PRIVATE_CERTS_FILE ]]; then 
    export REQUESTS_CA_BUNDLE=$PRIVATE_CERTS_FILE
    
fi

KEYNAME="$HOSTNAME-`date '+%F'`"

ssh-keygen -t ed25519 -C "beolson@hero4hire.com"  -f $HOME/.ssh/id_ed25519

if ! gh auth status >/dev/null 2>&1; then
    gh auth login -h github.com -p https -s admin:public_key
fi

gh ssh-key add $HOME/.ssh/id_ed25519.pub -t "$KEYNAME"
echo "KEYNAME = $KEYNAME"

echo '******************* copy dotfiles gitconfig'
