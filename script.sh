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

git clone https://github.com/DevInfinix/android-aosp-local-manifests --depth 1 -b 14-derp-bleeding-edge .repo/local_manifests

/opt/crave/resync.sh

source build/envsetup.sh

lunch derp_ice-userdebug

mka bacon
