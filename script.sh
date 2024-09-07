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
# rm -rf packages/apps/ViMusic
# rm -rf packages/apps/Droid-ify


echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"


# Repo Init
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs --depth=1

echo "========================================================================"
echo "REPO INITIALIZED"
echo "========================================================================"


# Clone local_manifests repository
git clone https://github.com/DevInfinix/android-aosp-local-manifests --depth 1 -b 14-rising .repo/local_manifests
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
git clone https://github.com/DevInfinix/devinfinix-aosp-roms-keys -b 14.0 temp-repo
mkdir "$DIRKEYS"
mv temp-repo/RisingOs-14/* "$DIRKEYS"
rm -rf temp-repo

echo "========================================================================"
echo "CLONED KEYS"
echo "========================================================================"


echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"


# RISEUP
source build/envsetup.sh
riseup ice userdebug
rise b
