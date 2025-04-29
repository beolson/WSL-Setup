#!/bin/bash 

echo '******************* install Go Starting'

ARCH=$(uname -m)
INSTALL_LOCATION="/usr/local/"
START_MARKER="### Begin Go ###"
END_MARKER="### End Go ###"

if [[ "$ARCH" == "x86_64" ]]; then
    DOWNLOAD_URL="https://go.dev/dl/go1.23.3.linux-amd64.tar.gz"
    ARCHIVE_FILE="go1.23.3.linux-amd64.tar.gz"
    CHECKSUM="a0afb9744c00648bafb1b90b4aba5bdb86f424f02f9275399ce0c20b93a2c3a8"
elif [[ "$ARCH" == "arm"* ]]; then
    DOWNLOAD_URL="https://go.dev/dl/go1.23.3.linux-arm64.tar.gz"
    ARCHIVE_FILE="go1.23.3.linux-arm64.tar.gz"
    CHECKSUM="1f7cbd7f668ea32a107ecd41b6488aaee1f5d77a66efd885b175494439d4e1ce"
else
    echo 
    return "Unsupported architecture: $ARCH" 2>/dev/null || exit "Unsupported architecture: $ARCH"
fi

wget $DOWNLOAD_URL
if ! echo "$CHECKSUM $ARCHIVE_FILE" | sha256sum -c -; then
    rm $ARCHIVE_FILE
    echo "Checksum failed" >&2
    exit 1
fi

sudo mkdir -p $INSTALL_LOCATION 
sudo tar zxf $ARCHIVE_FILE -C $INSTALL_LOCATION

export  PATH=$PATH:$INSTALL_LOCATION 

{
    echo "export PATH=\$PATH:$INSTALL_LOCATION"
} >> /etc/profile.d/go.sh

chmod +x /etc/profile.d/go.sh

rm $ARCHIVE_FILE

echo '******************* install Go completed'
