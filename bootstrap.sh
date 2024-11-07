#!/bin/bash -i

readonly GIT_CREDENTIAL_MANAGER_URL='https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.5.0/gcm-linux_amd64.2.5.0.deb';
readonly GIT_CREDENTIAL_MANAGER_CHECKSUM='d50ed45408fc76ae82bced4025514987f8c8e9e7c2ab9f4bf57ccbc854d68b3e  gcm.deb'
readonly DOT_FILES_REPO='https://github.com/beolson/Dotfiles.git'

sudo apt update
sudo apt upgrade -y

# Install any certificates from the certs folder into our WSL instance
# if [ -d "./certs" ]; then
#     sudo cp -r ./certs/ /usr/local/share/ca-certificates/
#     sudo chmod -R 0655 /usr/local/share/ca-certificates/wincerts/
#     sudo /usr/sbin/update-ca-certificates
# fi

CERTS="./certs/*"
for f in $CERTS
do
    echo "copying $f into cert store"
    sudo chmod 0655 $f
    sudo cp $f /usr/local/share/ca-certificates/
done
sudo /usr/sbin/update-ca-certificates
read -p "Press any key..."

# WSLU (Windows Services for Linux) - A collection of resources.
# Primary one allows us to open a windows browser from our linux shell
# xdg-utils (along with WSLU) allows git cred manager to open a windows browser for auth
# stow is used for managing our dotfiles
sudo apt install -y wslu xdg-utils stow


# Install Git Credential Manage
wget $GIT_CREDENTIAL_MANAGER_URL -O gcm.deb
if ! echo $GIT_CREDENTIAL_MANAGER_CHECKSUM | sha256sum --check -; then
    echo "Git Credential Manager Checksum failed" >&2
    exit 1
fi
sudo apt install ./gcm.deb
rm ./gcm.deb



#Setup OhMyBash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

# Clone our Dotfiles repo, and setup dotfiles with stow
if [ ! -d "~/.dotfiles" ]; then  
    git -c credential.credentialStore=cache -c credential.helper=/usr/local/bin/git-credential-manager -c credential.guiPrompt=false clone $DOT_FILES_REPO ~/.dotfiles
    
    # run our stow script *
    cd ~/.dotfiles 
    source setup.sh 
    cd ~

    #
fi

#setup nvm and pnpm and global node packages
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
wget -qO- https://get.pnpm.io/install.sh | sh -



echo '********************************************'
echo '********************************************'
echo '****************Setup Complete**************'
echo '********************************************'
echo '********************************************'

exit