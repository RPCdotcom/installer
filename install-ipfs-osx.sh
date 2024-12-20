#!/bin/bash

# This script installs IPFS.
# https://github.com/ipfs/kubo/releases/download/v0.29.0/kubo_v0.29.0_linux-arm64.tar.gz
# https://github.com/ipfs/kubo/releases/download/v0.29.0/kubo_v0.29.0_darwin-amd64.tar.gz

# Navigate to the directory where the script resides
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $DIR

echo "Starting IPFS installation process..."
echo "======================================="

echo "1. Downloading IPFS package - Darwin ARM64"
# Download the IPFS package
IPFS_VERSION="v0.29.0"
IPFS_PACKAGE="kubo_${IPFS_VERSION}_darwin-arm64.tar.gz"
IPFS_URL="https://github.com/ipfs/kubo/releases/download/${IPFS_VERSION}/${IPFS_PACKAGE}"

curl -fsSL $IPFS_URL -o $IPFS_PACKAGE
if [[ $? -ne 0 || ! -f $IPFS_PACKAGE ]]; then
    echo "   - Error: Failed to download or find the IPFS package at $IPFS_URL"
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
mkdir -p ~/bin
sudo cp -Rfv ./kubo/ipfs ~/bin/
if [[ $? -ne 0 ]]; then
    echo "   - Error: Failed to install IPFS"
    exit 1
fi
echo "   - IPFS installed successfully"

echo "======================================="
echo "IPFS installation process completed successfully!"
