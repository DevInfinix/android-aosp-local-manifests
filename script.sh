#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf vendor/oplus
rm -rf vendor/lineage-priv/keys/
rm -rf packages/apps/RevampedFMRadio
rm -rf packages/apps/Droid-ify
rm -rf packages/apps/ViMusic
rm -rf packages/apps/ViPER4AndroidFX


echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"


# Upgrade System

sudo apt update && sudo apt upgrade -y

echo "========================================================================"
echo "SYSTEM UPGRADED"
echo "========================================================================"


# Repo Init

repo init -u https://github.com/RisingOS-staging/android -b fifteen --git-lfs --depth=1

echo "========================================================================"
echo "REPO INITIALIZED"
echo "========================================================================"


# Clone local_manifests repository

git clone https://github.com/DevInfinix/android-aosp-local-manifests --depth 1 -b 15-rising .repo/local_manifests
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


# TEMP: Patch build/soong to allow oplus packages

cd build/soong
git fetch https://github.com/RisingTechOSS/android_build_soong fourteen
git cherry-pick 87df93b1ea08c751e2047b3d9e36bda487945e28
cd ../..


# Clone Keys

DIRKEYS="vendor/lineage-priv/keys/"
# Check if the directory exists
if [ -d "$DIRKEYS" ]; then
    echo "Directory $DIRKEYS exists. Deleting it..."
    rm -rf "$DIRKEYS"
    echo "Directory deleted."
else
    echo "Directory $DIRKEYS does not exist. No need to delete."
fi

echo "Cloning the repository..."
git clone https://github.com/DevInfinix/devinfinix-aosp-roms-keys --depth=1 -b 14.0-los21 "$DIRKEYS"

echo "========================================================================"
echo "CLONED KEYS"
echo "========================================================================"


echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"


# Set some environment variables

export TZ=Asia/Kolkata
export BUILD_USERNAME=DevInfinix
export BUILD_HOSTNAME=Garudinix


# RISEUP

source build/envsetup.sh
riseup ice userdebug
rise b
