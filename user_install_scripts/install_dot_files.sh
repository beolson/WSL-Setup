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
