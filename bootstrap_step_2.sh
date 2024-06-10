#!/bin/bash -i

nvm install v20.14.0 
pnpm config set cafile /etc/ssl/certs/ca-certificates.crt -g
pnpm install @devcontainers/cli -g


echo '********************************************'
echo '********************************************'
echo '****************Setup Complete**************'
echo '********************************************'
echo '********************************************'

# Setup Git Credentials manage
# Configure Git Credentials Manage
# Setup Git
# Setup git config

# Setup OhMyBash
# Config OhMyBash

# if ! grep -qF "/mnt/dev" /etc/fstab; then
#   echo "/dev/sda1 /mnt/dev ext4 defaults 0 0" | sudo tee -a /etc/fstab
# fi

# if [ -d "./certs" ]; then
# sudo dd of=/etc/profile.d/gitconfig.sh << EOF
# export GCM_CREDENTIAL_STORE=cache
# export GCM_AZREPOS_CREDENTIALTYPE="oauth"
# EOF
# fi



#https://stevenrbaker.com/tech/managing-dotfiles-with-gnu-stow.html
#https://www.jakewiesler.com/blog/managing-dotfiles
#https://stackoverflow.com/questions/28185913/how-to-read-and-parse-the-json-file-and-add-it-into-the-shell-script-variable
