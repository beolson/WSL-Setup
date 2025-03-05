#!/bin/bash 

echo '******************* install Dot Net starting'
ARCH=$(uname -m)
INSTALL_LOCATION="/usr/local/dotnet"

if [[ "$ARCH" == "x86_64" ]]; then
    DOWNLOAD_URL="https://download.visualstudio.microsoft.com/download/pr/308f16a9-2ecf-4a42-b8bb-c1233de985fd/be6e87045ab21935bd8bb98ce69026c4/dotnet-sdk-9.0.100-linux-x64.tar.gz"
    ARCHIVE_FILE="dotnet-sdk-9.0.100-linux-x64.tar.gz"
    CHECKSUM="7f69bda047de1f952286be330a5e858171ded952d1aa24169e62212f90a27149e63b636c88ad313a6e3ec860da31f8c547ff4ab6808103a070f7fb26ba99c1c7"
elif [[ "$ARCH" == "arm"* ]]; then
    DOWNLOAD_URL="https://download.visualstudio.microsoft.com/download/pr/6f79d99b-dc38-4c44-a549-32329419bb9f/a411ec38fb374e3a4676647b236ba021/dotnet-sdk-9.0.100-linux-arm64.tar.gz"
    ARCHIVE_FILE="dotnet-sdk-9.0.100-linux-arm64.tar.gz"
    CHECKSUM="684450e6d1f7c711fffdbf32a2b86a932d17a51f4742bd27a4289e319c5b24f6743553fc7e0ad1c7163e448ed5c40cd1ecf4198b2e681acc4622d8e6193a5cf2"
else
    echo 
    return "Unsupported architecture: $ARCH" 2>/dev/null || exit "Unsupported architecture: $ARCH"
fi

sudo apt install -y ca-certificates libc6 libgcc-s1 libgssapi-krb5-2 libicu74 liblttng-ust1 libssl3 libstdc++6 libunwind8 zlib1g

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
