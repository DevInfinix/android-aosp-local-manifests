#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme/ice
rm -rf kernel/oplus/RMX3461
rm -rf vendor/realme/ice
rm -rf hardware/oplus
rm -rf device/oneplus/sm8350-common
rm -rf vendor/oneplus/sm8350-common
rm -rf vendor/oplus/camera  
rm -rf vendor/qcom/opensource/vibrator

echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"

git clone https://github.com/DevInfinix/android-aosp-local-manifests --depth 1 -b 14-derp-bleeding-edge .repo/local_manifests

echo "========================================================================"
echo "CLONED REPOS"
echo "========================================================================"

/opt/crave/resync.sh

source build/envsetup.sh

echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"

lunch derp_ice-userdebug
mka bacon

echo "========================================================================"
echo "BUILT ROM SUCCESSFULLY!"
echo "========================================================================"

# Find the path of the zip file in the 'ice' folder
ICE_FOLDER="ice"
ZIP_FILE=$(find "$ICE_FOLDER" -name "*.zip" -type f -print -quit)

# Check if a zip file was found
if [ -n "$ZIP_FILE" ]; then
    echo "Found zip file: $ZIP_FILE"

    # Upload to bashupload.com
    echo "Uploading to bashupload.com..."
    curl bashupload.com -T "$ZIP_FILE"

    # Upload to pixeldrain.com
    echo "Uploading to pixeldrain.com..."
    curl -T "$ZIP_FILE" https://pixeldrain.com/api/file/

    echo "========================================================================"
    echo "UPLOAD COMPLETED!"
    echo "========================================================================"
else
    echo "========================================================================"
    echo "No zip file found in the 'ice' folder."
    echo "========================================================================"
fi
