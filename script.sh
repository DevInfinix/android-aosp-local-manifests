#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf vendor/oplus

# Cleanup to fix SyncErrors raised during branch checkouts
rm -rf platform/prebuilts
rm -rf prebuilts

echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"


# Upgrade System

sudo apt update && sudo apt upgrade -y

echo "========================================================================"
echo "SYSTEM UPGRADED"
echo "========================================================================"


# Repo Init

repo init -u https://github.com/yaap/manifest.git -b fifteen --git-lfs --depth=1

echo "========================================================================"
echo "REPO INITIALIZED"
echo "========================================================================"


# Clone local_manifests repository

git clone https://github.com/DevInfinix/android-aosp-local-manifests --depth 1 -b 15-yaap .repo/local_manifests
if [ ! 0 == 0 ]
    then curl -o .repo/local_manifests https://github.com/DevInfinix/android-aosp-local-manifests.git
fi

echo "========================================================================"
echo "CLONED REPOS"
echo "========================================================================"


# Resync

/opt/crave/resync.sh

echo "========================================================================"
echo "RESYNCED"
echo "========================================================================"


# Clone Keys

DIRKEYS="vendor/yaap/signing/keys/"
# Check if the directory exists
if [ -d "$DIRKEYS" ]; then
    echo "Directory $DIRKEYS exists. Deleting it..."
    rm -rf "$DIRKEYS"
    echo "Directory deleted."
else
    echo "Directory $DIRKEYS does not exist. No need to delete."
fi

echo "Cloning the repository..."
git clone https://github.com/DevInfinix/devinfinix-aosp-roms-keys --depth=1 -b 15.0-testing "$DIRKEYS"

echo "========================================================================"
echo "CLONED KEYS"
echo "========================================================================"


# Set LD_LIBRARY_PATH (libgcc_s.so.1 linker)

export LD_LIBRARY_PATH=/usr/aarch64-linux-gnu/bin:/$LD_LIBRARY_PATH


# Temp fix: Remove Seedvault

rm -rf external/seedvault


echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"


# LUNCH
source build/envsetup.sh
lunch yaap_ice-userdebug
make installclean
m yaap
