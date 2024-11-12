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

# Temp
rm -rf vendor/pixelage

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


# Clone Keys

DIRKEYS="vendor/pixelage-priv/keys"
# Check if the directory exists
if [ -d "$DIRKEYS" ]; then
    echo "Directory $DIRKEYS exists. Deleting it..."
    rm -rf "$DIRKEYS"
    echo "Directory deleted."
    echo "Cloning the repository..."
    git clone https://github.com/DevInfinix/devinfinix-aosp-roms-keys --depth=1 -b 15.0-pixelage tmp-keys
    cp tmp-keys/* $DIRKEYS
    rm -rf tmp-keys/Android.bp
else
    echo "Directory $DIRKEYS does not exist. No need to delete."
    git clone https://github.com/DevInfinix/devinfinix-aosp-roms-keys --depth=1 -b 15.0-pixelage "$DIRKEYS"
    echo "Cloned old keys instead!"
fi


echo "========================================================================"
echo "CLONED KEYS"
echo "========================================================================"


# TEMP: Attempt to fix llvm errors

cd vendor/pixelage
git revert e1022e42d5541a75bda94d86a3c49da30401c8b4
cd ../..

echo "========================================================================"
echo "REVERTED LLVM COMMIT"
echo "========================================================================"


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
