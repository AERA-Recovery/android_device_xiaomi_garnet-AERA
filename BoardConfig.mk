#
# Copyright 2017 The Android Open Source Project
#
# Copyright (C) 2024-2026 The OrangeFox Recovery Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

# Inherit from common
-include $(COMMON_PATH)/BoardConfigCommon.mk

# Recovery
TARGET_OTA_ASSERT_DEVICE := garnet

# TWRP specific build flags
TW_FRAMERATE := 120

# Vibrator
ifeq ($(FIXED_HAPTICS),1)
  TW_SUPPORT_INPUT_AIDL_HAPTICS := true
  TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true
  TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := "IVibrator/vibratorfeature"
else
   TW_NO_HAPTICS := true
endif

TARGET_RECOVERY_DEVICE_MODULES += libexpat
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libexpat.so

# default brightness
TW_DEFAULT_BRIGHTNESS := 1023

# max brightness
TW_MAX_BRIGHTNESS := 3071

# enable screen blanking (disable this if some touch panels misbehave)
TW_NO_SCREEN_BLANK := true

# device-specific system/vendor props
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# device-specific fstab
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

# kernel
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel

# -------- from lineage DT -------------
# we're qcom
BOARD_USES_QCOM_HARDWARE := true

BOARD_USES_GENERIC_KERNEL_IMAGE := true

TW_USE_LEGACY_BATTERY_SERVICES := true

TARGET_RECOVERY_DEVICE_MODULES += android.hardware.security.keymint-V1-ndk
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.security.keymint-V1-ndk.so
BOARD_RECOVERY_IMAGE_PREPARE += mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/system/lib64; ln -sf android.hardware.security.keymint-V1-ndk.so $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/android.hardware.security.keymint-V1-ndk_platform.so; ln -sf android.hardware.security.secureclock-V1-ndk.so $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/android.hardware.security.secureclock-V1-ndk_platform.so; ln -sf android.hardware.security.sharedsecret-V1-ndk.so $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/android.hardware.security.sharedsecret-V1-ndk_platform.so;
# sm84xx-common's twrp/recovery/root is copied AFTER ours (deferred inherit-product
# appends $(COMMON_PATH)/twrp last in TARGET_RECOVERY_DEVICE_DIRS), so its outdated
# keymint .rc overwrites our fixed one. Re-copy ours at recipe time (runs after the
# recovery-root copy) so the keymint HAL starts with rkp-V3 LD_PRELOAD and decryption works.
BOARD_RECOVERY_IMAGE_PREPARE += cp -f $(DEVICE_PATH)/recovery/root/vendor/etc/init/android.hardware.security.keymint-service-qti.rc $(TARGET_RECOVERY_ROOT_OUT)/vendor/etc/init/android.hardware.security.keymint-service-qti.rc;

TW_POST_DECRYPT_MODULES := "cnss_prealloc.ko cnss_nl.ko wlan_firmware_service.ko cnss_utils.ko icnss2.ko rmnet_perf.ko rmnet_shs.ko rmnet_aps.ko rmnet_offload.ko rmnet_perf_tether.ko rmnet_wlan.ko rmnet_core.ko rmnet_ctl.ko cfg80211.ko gsim.ko ipam.ko qca_cld3_adrastea.ko"
#
