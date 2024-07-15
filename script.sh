#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf vendor/oplus
rm -rf vendor/qcom/opensource/vibrator

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
/opt/crave/resynctest.sh

echo "========================================================================"
echo "RESYNCED"
echo "========================================================================"

# Clone Vibrator

DIR="vendor/qcom/opensource/vibrator"
# Check if the directory exists
if [ -d "$DIR" ]; then
    echo "Directory $DIR exists. Deleting it..."
    rm -rf "$DIR"
    echo "Directory deleted."
else
    echo "Directory $DIR does not exist. No need to delete."
fi

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/DevInfinix/android_vendor_qcom_opensource_vibrator -b 14-derp-bleeding-edge "$DIR"
echo "Repository cloned."

echo "========================================================================"
echo "CLONED VIBRATOR"
echo "========================================================================"

echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"

# LUNCH
source build/envsetup.sh
lunch derp_ice-userdebug
make installclean
mka bacon
