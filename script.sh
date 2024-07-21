#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf vendor/oplus
rm -rf vendor/derp/signing/keys
rm -rf vendor/qcom/opensource/vibrator
rm -rf packages/apps/ViMusic
rm -rf packages/apps/Droid-ify

echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"


# Clone local_manifests repository
git clone https://github.com/DevInfinix/android-aosp-local-manifests --depth 1 -b 14-derp-bleeding-edge .repo/local_manifests
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


# Clone Vibrator

DIRVIB="vendor/qcom/opensource/vibrator"
# Check if the directory exists
if [ -d "$DIRVIB" ]; then
    echo "Directory $DIRVIB exists. Deleting it..."
    rm -rf "$DIRVIB"
    echo "Directory deleted."
else
    echo "Directory $DIRVIB does not exist. No need to delete."
fi

echo "Cloning the repository..."
git clone https://github.com/DevInfinix/android_vendor_qcom_opensource_vibrator --depth 1 -b 14-derp-bleeding-edge "$DIRVIB"

echo "========================================================================"
echo "CLONED VIBRATOR"
echo "========================================================================"


# Clone Keys

DIRKEYS="vendor/derp/signing/keys"
# Check if the directory exists
if [ -d "$DIRKEYS" ]; then
    echo "Directory $DIRKEYS exists. Deleting it..."
    rm -rf "$DIRKEYS"
    echo "Directory deleted."
else
    echo "Directory $DIRKEYS does not exist. No need to delete."
fi

echo "Cloning the repository..."
git clone https://github.com/DevInfinix/devinfinix-aosp-roms-keys -b 14-derp-bleeding-edge "$DIRKEYS"

echo "========================================================================"
echo "CLONED KEYS"
echo "========================================================================"


# Clone ParanoidSense

rm -rf packages/apps/ParanoidSense
git clone https://github.com/DerpFest-AOSP/packages_apps_ParanoidSense --depth 1 -b 14 packages/apps/ParanoidSense

echo "========================================================================"
echo "CLONED ParanoidSense"
echo "========================================================================"


echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"


# LUNCH
source build/envsetup.sh
lunch derp_ice-eng
make installclean
mka bacon
