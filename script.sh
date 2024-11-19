#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf vendor/oplus
rm -rf packages/apps/ViPER4AndroidFX

# Cleanup to fix SyncErrors raised during branch checkouts
rm -rf prebuilts


echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"


# Repo Init

repo init -u https://github.com/ProjectPixelage/android_manifest.git -b 15 --git-lfs --depth=1

echo "========================================================================"
echo "REPO INITIALIZED"
echo "========================================================================"


# Clone local_manifests repository

git clone https://github.com/DevInfinix/android-aosp-local-manifests --depth 1 -b 15-pixelage .repo/local_manifests
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


# Upgrade System

sudo apt update && sudo apt upgrade -y

echo "========================================================================"
echo "SYSTEM UPGRADED"
echo "========================================================================"


# Clone Custom Clang

#CUSTOMCLANG="r522817"
#rm -rf "prebuilts/clang/host/linux-x86/clang-${CUSTOMCLANG}"
#git clone "https://gitlab.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-${CUSTOMCLANG}" --depth=1 -b 15.0 "prebuilts/clang/host/linux-x86/clang-${CUSTOMCLANG}"
#echo "========================================================================"
#echo "CLONED CUSTOM CLANG"
#echo "========================================================================"

rm -rf "prebuilts/clang/host/linux-x86/clang-azure"
git clone https://gitlab.com/Panchajanya1999/azure-clang --depth=1 -b main "prebuilts/clang/host/linux-x86/clang-azure"

echo "========================================================================"
echo "CLONED CUSTOM CLANG"
echo "========================================================================"


# Clone Keys [Use default for now]

#DIRKEYS="vendor/pixelage-priv/keys"
#rm -rf tmp-keys
# Check if the directory exists
#if [ -d "$DIRKEYS" ]; then
#    echo "Directory $DIRKEYS exists. Deleting it..."
#    rm -rf "$DIRKEYS"
#    echo "Directory deleted."
#    echo "Cloning the repository..."
#else
#    echo "Directory $DIRKEYS does not exist. No need to delete."
#    echo "Cloned old keys instead!"
#fi

#mkdir -p $DIRKEYS
#git clone https://github.com/DevInfinix/devinfinix-aosp-roms-keys --depth=1 -b 15.0-pixelage tmp-keys
#rm -rf tmp-keys/Android.bp
#cp tmp-keys/* $DIRKEYS

#echo "========================================================================"
#echo "CLONED KEYS"
#echo "========================================================================"


echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"


# Set some environment variables
export TZ=Asia/Kolkata
export BUILD_USERNAME=DevInfinix
export BUILD_HOSTNAME=Garudinix


# Lunch
export PIXELAGE_BUILD="ice"
source build/envsetup.sh
lunch pixelage_ice-ap3a-userdebug
make installclean
mka bacon
