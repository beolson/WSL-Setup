#!/bin/bash 

echo '******************* install Dot Net starting'
ARCH=$(uname -m)
INSTALL_LOCATION="/usr/local/dotnet"


if [[ "$ARCH" == "x86_64" ]]; then
    DOWNLOAD_URL="https://download.visualstudio.microsoft.com/download/pr/4e3b04aa-c015-4e06-a42e-05f9f3c54ed2/74d1bb68e330eea13ecfc47f7cf9aeb7/dotnet-sdk-8.0.404-linux-x64.tar.gz"
    ARCHIVE_FILE="dotnet-sdk-8.0.404-linux-x64.tar.gz"
    CHECKSUM="2f166f7f3bd508154d72d1783ffac6e0e3c92023ccc2c6de49d22b411fc8b9e6dd03e7576acc1bb5870a6951181129ba77f3bf94bb45fe9c70105b1b896b9bb9"
elif [[ "$ARCH" == "arm"* ]]; then
    DOWNLOAD_URL="https://download.visualstudio.microsoft.com/download/pr/0f1c8c1a-a14d-451e-8a14-4088b0d29cf0/37d7a2637468a506214ce484985fe040/dotnet-sdk-8.0.403-osx-arm64.tar.gz"
    ARCHIVE_FILE="dotnet-sdk-8.0.403-osx-arm64.tar.gz"
    CHECKSUM="f3dafcc39e131de9bffff190aecc08d87aa0625a66245af55c019b5cb64d1593cdabf652c197ce4152bbd7c54cf68c273499d969a34885e3b7df0890bf5c9336"
else
    echo 
    return "Unsupported architecture: $ARCH" 2>/dev/null || exit "Unsupported architecture: $ARCH"
fi



wget $DOWNLOAD_URL
if ! echo "$CHECKSUM $ARCHIVE_FILE" | sha512sum -c -; then
    rm $ARCHIVE_FILE
    echo "Checksum failed" >&2
    exit 1
fi

sudo mkdir -p $INSTALL_LOCATION 
sudo tar zxf $ARCHIVE_FILE -C $INSTALL_LOCATION

export DOTNET_ROOT=$INSTALL_LOCATION
export PATH=$PATH:$INSTALL_LOCATION

{
    echo "export DOTNET_ROOT=$INSTALL_LOCATION"
    echo "export PATH=\$PATH:$INSTALL_LOCATION"

} >> /etc/profile.d/dotnet.sh

chmod +x /etc/profile.d/dotnet.sh

rm $ARCHIVE_FILE

echo '******************* install Dot Net completed'
