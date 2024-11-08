#!/bin/bash -i

echo '******************* upgrade starting'

sudo apt update
sudo apt upgrade -y

echo '******************* upgrade complete'
#!/bin/bash -i

echo '******************* configure ca certs starting'

CERTS="./certs/*"
for f in $CERTS
do
    echo "copying $f into cert store"
    sudo chmod 0655 $f
    sudo cp $f /usr/local/share/ca-certificates/
done
sudo /usr/sbin/update-ca-certificates

echo '******************* configure ca certs complete'
#!/bin/bash -i

echo '******************* install wsl tools starting'

sudo apt install -y wslu xdg-utils stow

echo '******************* install wsl tools completed'
#!/bin/bash -i

echo '******************* install Git Credential Manager starting'

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
#!/bin/bash -i

echo '******************* install Oh My Bash starting'

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

echo '******************* install Oh My Bash completed'
#!/bin/bash -i

echo '******************* install Node starting'

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
wget -qO- https://get.pnpm.io/install.sh | sh -

echo '******************* install Node completed'
#!/bin/bash -i

echo '******************* configure Dot Files starting'

readonly DOT_FILES_REPO='https://github.com/beolson/Dotfiles.git'

# Clone our Dotfiles repo, and setup dotfiles with stow
if [ ! -d "~/.dotfiles" ]; then  
    git -c credential.credentialStore=cache -c credential.helper=/usr/local/bin/git-credential-manager -c credential.guiPrompt=false clone $DOT_FILES_REPO ~/.dotfiles
    
    # run our stow script *
    cd ~/.dotfiles 
    source setup.sh 
    cd ~

fi

echo '******************* configure Dot Files starting'
