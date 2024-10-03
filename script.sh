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

echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"


# Repo Init
repo init -u https://github.com/ProjectBlaze/manifest -b 15 --git-lfs --depth=1

echo "========================================================================"
echo "REPO INITIALIZED"
echo "========================================================================"


# Clone local_manifests repository
git clone https://github.com/DevInfinix/android-aosp-local-manifests --depth 1 -b 15-blaze .repo/local_manifests
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


# Upgrade System and install openssl

sudo apt update && sudo apt upgrade -y

echo "========================================================================"
echo "SYSTEM UPGRADED"
echo "========================================================================"


# Clone Custom Clang

CUSTOMCLANG="azure"
rm -rf "prebuilts/clang/host/linux-x86/clang-${CUSTOMCLANG}"
git clone https://gitlab.com/Panchajanya1999/azure-clang --depth=1 -b main prebuilts/clang/host/linux-x86/clang-${CUSTOMCLANG}

echo "========================================================================"
echo "CLONED CUSTOM CLANG"
echo "========================================================================"


# Clone Keys

DIRKEYS="vendor/blaze/signing/keys/"
# Check if the directory exists
if [ -d "$DIRKEYS" ]; then
    echo "Directory $DIRKEYS exists. Deleting it..."
    rm -rf "$DIRKEYS"
    echo "Directory deleted."
else
    echo "Directory $DIRKEYS does not exist. No need to delete."
fi

echo "Cloning the repository..."
git clone https://github.com/DevInfinix/devinfinix-aosp-roms-keys --depth=1 -b 15.0-blaze "$DIRKEYS"

echo "========================================================================"
echo "CLONED KEYS"
echo "========================================================================"


echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"


# Lunch
source build/envsetup.sh
lunch blaze_ice-ap3a-userdebug
make installclean
make bacon
