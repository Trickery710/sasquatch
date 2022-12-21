#!/bin/bash
# Script to download squashfs-tools v4.3, apply the patches, perform a clean build, and install.

# If not root, perform 'make install' with sudo
if [ $UID -eq 0 ]
then
    SUDO=""
else
    SUDO="sudo"
fi

# Install prerequisites
if hash apt-get &>/dev/null
then
    $SUDO apt-get install build-essential liblzma-dev liblzo2-dev zlib1g-dev
fi

# Make sure we're working in the same directory as the build.sh script
cd $(dirname `readlink  -f $0`)

# Download squashfs4.5.1.tar.gz if it does not already exist
if [ ! -e squashfs4.5.1.tar.gz ]
then
    wget https://sourceforge.net/projects/squashfs/files/squashfs/squashfs4.5.1/squashfs4.5.1.tar.gz
fi

# Remove any previous squashfs4.3 directory to ensure a clean patch/build
rm -rf squashfs4.5.1

# Extract squashfs4.3.tar.gz
tar -zxvf ./squashfs4.5.1.tar.gz


#sed '1841 s/read_fs_bytes/else read_fs_bytes/'    ./squashfs4.3/squashfs-tools/unsquashfs.c
# Patch, build, and install the source
cd squashfs4.5.1
cd squashfs-tools
make && $SUDO make install
