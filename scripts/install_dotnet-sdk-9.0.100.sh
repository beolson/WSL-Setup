#!/bin/bash 

echo '******************* install Dot Net starting'
ARCH=$(uname -m)
INSTALL_LOCATION="/usr/local/dotnet"
DOWNLOAD_URL="https://download.visualstudio.microsoft.com/download/pr/308f16a9-2ecf-4a42-b8bb-c1233de985fd/be6e87045ab21935bd8bb98ce69026c4/dotnet-sdk-9.0.100-linux-x64.tar.gz"
ARCHIVE_FILE="dotnet-sdk-9.0.100-linux-x64.tar.gz"
CHECKSUM="7f69bda047de1f952286be330a5e858171ded952d1aa24169e62212f90a27149e63b636c88ad313a6e3ec860da31f8c547ff4ab6808103a070f7fb26ba99c1c7"

wget $DOWNLOAD_URL
if ! echo "$CHECKSUM $ARCHIVE_FILE" | sha512sum -c -; then
    rm $ARCHIVE_FILE
    echo "Checksum failed" >&2
    exit 1
fi

mkdir -p $INSTALL_LOCATION 
tar zxf $ARCHIVE_FILE -C $INSTALL_LOCATION

export DOTNET_ROOT=$INSTALL_LOCATION
export PATH=$PATH:$INSTALL_LOCATION

{
    echo "export DOTNET_ROOT=$INSTALL_LOCATION"
    echo "export PATH=\$PATH:$INSTALL_LOCATION"
} >> /etc/profile.d/dotnet.sh

chmod +x /etc/profile.d/dotnet.sh

rm $ARCHIVE_FILE

echo '******************* install Dot Net completed'
