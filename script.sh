#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf vendor/oplus
rm -rf vendor/voltage-priv/keys/


echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"


# Repo Init 
repo init -u https://github.com/VoltageOS/manifest.git -b 14 --git-lfs --depth=1

echo "========================================================================"
echo "REPO INITIALIZED"
echo "========================================================================"


# Clone local_manifests repository
git clone https://github.com/DevInfinix/android-aosp-local-manifests --depth 1 -b 14-vos .repo/local_manifests
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


# Clone Keys

DIRKEYS="vendor/voltage-priv/keys/"
# Check if the directory exists
if [ -d "$DIRKEYS" ]; then
    echo "Directory $DIRKEYS exists. Deleting it..."
    rm -rf "$DIRKEYS"
    echo "Directory deleted."
else
    echo "Directory $DIRKEYS does not exist. No need to delete."
fi

echo "Cloning the repository..."
git clone https://github.com/DevInfinix/devinfinix-aosp-roms-keys --depth=1 -b 14.0-voltage "$DIRKEYS"

echo "========================================================================"
echo "CLONED KEYS"
echo "========================================================================"


# Temp Fix: Nuke ParanoidSense

rm -rf packages/apps/ParanoidSense


echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"


# RISEUP
source build/envsetup.sh
lunch voltage_ice-ap2a-userdebug
mka bacon
