#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf vendor/oplus
rm -rf packages/apps/RevampedFMRadio
rm -rf packages/apps/Droid-ify
rm -rf packages/apps/PixelParts
rm -rf packages/apps/ViMusic
rm -rf packages/apps/ViPER4AndroidFX

# Cleanup to fix SyncErrors raised during branch checkouts
rm -rf platform/prebuilts


echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"


# Repo Init

repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 15 --git-lfs --depth=1

echo "========================================================================"
echo "REPO INITIALIZED"
echo "========================================================================"


# Clone local_manifests repository

git clone https://github.com/DevInfinix/android-aosp-local-manifests --depth 1 -b 15-derp .repo/local_manifests
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

CUSTOMCLANG="r487747c"
rm -rf "prebuilts/clang/host/linux-x86/clang-${CUSTOMCLANG}"
git clone "https://gitlab.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-${CUSTOMCLANG}" --depth=1 -b 14.0 "prebuilts/clang/host/linux-x86/clang-${CUSTOMCLANG}"

echo "========================================================================"
echo "CLONED CUSTOM CLANG"
echo "========================================================================"


# Clone Keys

DIRKEYS="vendor/derp/signing/keys/"
# Check if the directory exists
if [ -d "$DIRKEYS" ]; then
    echo "Directory $DIRKEYS exists. Deleting it..."
    rm -rf "$DIRKEYS"
    echo "Directory deleted."
else
    echo "Directory $DIRKEYS does not exist. No need to delete."
fi

echo "Cloning the repository..."
git clone https://github.com/DevInfinix/devinfinix-aosp-roms-keys --depth=1 -b 15.0-derp "$DIRKEYS"

echo "========================================================================"
echo "CLONED KEYS"
echo "========================================================================"


echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"


# Lunch
source build/envsetup.sh
lunch derp_ice-userdebug
make installclean
mka derp
