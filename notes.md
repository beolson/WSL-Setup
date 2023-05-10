


# Allow WSL to trust zscaler cert

```bash
sudo apt-get install -y ca-certificates
sudo cp zscaler.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates


export NODE_EXTRA_CA_CERTS=~/src/zscaler.pem
```

# Install Git Cred Manager
This will install it as a stand alone.  There is an aternative way that installs is sharing the windows credential store.  

```bash
wget --no-check-certificate  "https://github.com/GitCredentialManager/git-credential-manager/releases/download/v2.0.886/gcm-linux_amd64.2.0.886.deb" -O /tmp/gcmcore.deb

sudo dpkg -i /tmp/gcmcore.deb

git-credential-manager configure

git config --global --replace-all credential.helper "/mnt/c/Users/brian.olson/AppData/Local/Programs/Git/mingw64/bin/git-credential-manager.exe"


 libsecret-1-0
apt-get install  
libsecret-1-0
libsm6

```


# Install Volta 
```
curl https://get.volta.sh | bash
```

# WSL Commands
 - `wsl --list -v` list all distros and current state
 - `wsl --shutdown` stop all running distros
 - `wsl --unregister <NAME>` Delete the distro and all files
 - `wsl --install -d <Distribution Name>` Setup new distro
 - `wsl --list --online` list available distros
 - `wsl --export <distro> <filename.tar>` copy (backup) distro
 - `wsl --import (distribution) (install location) (file location and filename)` restore distro from copy
 
 # WSL Config
 - located at `/etc/wsl.conf`
 
 ```
[interop]
enabled = false
appendWindowsPath = false
 ```
 
 
 ```
 
 sudo apt-get update
sudo apt-get install gcc
sudo apt-get install make
npm install -g @devcontainers/cli
 ```
 
 
 $cert = (Get-ChildItem -path Cert:\LocalMachine* -Recurse | where {$_.Subject -like '*CN=Zscaler Root CA*'})
 Export-Certificate -Cert $cert -Type CERT -FilePath C:\Temp\Mycert.cer
 certutil.exe -encode C:\Temp\Mycert.cer ./mycert.pem
 



 https://www.wslutiliti.es/wslu/install.html
https://github.com/git-ecosystem/git-credential-manager/issues/515
https://github.com/git-ecosystem/git-credential-manager/issues/515
git config --global credential.guiPrompt false
https://github.com/git-ecosystem/git-credential-manager/issues/1127
https://github.com/microsoft/WSL/issues/5232

# ansible debugging 

p result._result

\
https://unix.stackexchange.com/questions/368123/how-to-extract-the-root-ca-and-subordinate-ca-from-a-certificate-chain-in-linux

openssl s_client -showcerts -verify 5 -connect stackexchange.com:443 < /dev/null

https://stackoverflow.com/questions/17287713/using-iconv-to-convert-from-utf-16le-to-utf-8

\
https://www.reddit.com/r/linux4noobs/comments/r53rf1/where_to_store_deb_files/