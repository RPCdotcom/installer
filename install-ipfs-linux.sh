#!/bin/bash

# This script installs IPFS.
# For Linux or Darwin, update URLs accordingly.
# https://github.com/ipfs/kubo/releases/download/v0.29.0/kubo_v0.29.0_linux-arm64.tar.gz 
# https://github.com/ipfs/kubo/releases/download/v0.29.0/kubo_v0.29.0_darwin-amd64.tar.gz

# Navigate to the directory where the script resides
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $DIR

echo "Starting IPFS installation process..."
echo "======================================="

# Define the IPFS version and platform
IPFS_VERSION="v0.29.0"
PLATFORM=$(uname -s)
ARCHITECTURE=$(uname -m)

if [[ "$PLATFORM" == "Darwin" && "$ARCHITECTURE" == "arm64" ]]; then
    IPFS_PACKAGE="kubo_${IPFS_VERSION}_darwin-arm64.tar.gz"
    IPFS_URL="https://github.com/ipfs/kubo/releases/download/${IPFS_VERSION}/${IPFS_PACKAGE}"
elif [[ "$PLATFORM" == "Linux" && "$ARCHITECTURE" == "x86_64" ]]; then
    IPFS_PACKAGE="kubo_${IPFS_VERSION}_linux-amd64.tar.gz"
    IPFS_URL="https://github.com/ipfs/kubo/releases/download/${IPFS_VERSION}/${IPFS_PACKAGE}"
else
    echo "   - Error: Unsupported platform ${PLATFORM} ${ARCHITECTURE}."
    exit 1
fi

echo "1. Downloading IPFS package from $IPFS_URL"
# Download the IPFS package
curl -fsSL $IPFS_URL -o $IPFS_PACKAGE
if [[ $? -ne 0 ]]; then
    echo "   - Error: Failed to download IPFS package from $IPFS_URL"
    exit 1
fi
echo "   - IPFS package downloaded successfully"

echo "2. Extracting IPFS package"
# Extract the package
tar xzfv $IPFS_PACKAGE
if [[ $? -ne 0 ]]; then
    echo "   - Error: Failed to extract $IPFS_PACKAGE"
    exit 1
fi
echo "   - IPFS package extracted successfully"

echo "3. Installing IPFS"
# Run the installation script
cd ./kubo
sudo ./install.sh
if [[ $? -ne 0 ]]; then
    echo "   - Error: Failed to install IPFS"
    exit 1
fi
echo "   - IPFS installed successfully"

echo "======================================="
echo "IPFS installation process completed successfully!"
