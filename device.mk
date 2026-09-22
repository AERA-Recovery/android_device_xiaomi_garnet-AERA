#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2024-2026 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

# include (not inherit-product) the common settings - works better with device-specific files
-include $(COMMON_PATH)/device-common.mk

AERA_DEFAULT_LANGUAGE     := en
AERA_USE_TOOLBOX          := true
AERA_INCLUDE_NTFS_3G      := true
AERA_INCLUDE_REPACKTOOLS  := true
AERA_INCLUDE_LIBRESETPROP := true
AERA_EXTRA_LANGUAGES      := true
AERA_EXCLUDE_APEX         := true
AERA_INCLUDE_FASTBOOTD    := true

# OEM otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/recovery/security/miui

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# clear this, so that the device-specifc recovery/root/ folder is included automatically by the build system
# requires including, rather than inheriting the common settings
TARGET_RECOVERY_DEVICE_DIRS :=

# copy recovery/root/ from the common directory
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(COMMON_PATH)/twrp/recovery/root/,$(TARGET_COPY_OUT_RECOVERY)/root/)

# copy recovery/root/ from the device directory (if it exists)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)/recovery/root/,$(TARGET_COPY_OUT_RECOVERY)/root/)

# AERA-specific settings
$(call inherit-product, $(DEVICE_PATH)/aera_garnet.mk)

# modules
PRODUCT_PACKAGES += \
    aera-audio-bridge \
    aera-browser-jail \
    garnet_modules

# Garnet's Adreno 710 userspace and allocator are bundled from the matching
# stock dump. AERA retains its software-rendering fallback if initialization
# fails on a different firmware revision.
PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.egl=adreno \
    vendor.gralloc.disable_ubwc=0

PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)
#
