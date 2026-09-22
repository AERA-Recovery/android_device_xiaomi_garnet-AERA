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

# AERA UI
AERA_FRAMERATE := 120
AERA_UI2_ADAPTIVE_RESOLUTION := true

# Vibrator
ifeq ($(FIXED_HAPTICS),1)
  AERA_SUPPORT_INPUT_AIDL_HAPTICS := true
  AERA_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true
  AERA_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := "IVibrator/vibratorfeature"
else
  AERA_NO_HAPTICS := true
endif

TARGET_RECOVERY_DEVICE_MODULES += libexpat
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libexpat.so

# default brightness
AERA_DEFAULT_BRIGHTNESS := 1023

# max brightness
AERA_MAX_BRIGHTNESS := 3071

# enable screen blanking (disable this if some touch panels misbehave)
AERA_NO_SCREEN_BLANK := true

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

AERA_USE_LEGACY_BATTERY_SERVICES := true

TARGET_RECOVERY_DEVICE_MODULES += android.hardware.security.keymint-V1-ndk
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.security.keymint-V1-ndk.so
BOARD_RECOVERY_IMAGE_PREPARE += mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/system/lib64; ln -sf android.hardware.security.keymint-V1-ndk.so $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/android.hardware.security.keymint-V1-ndk_platform.so; ln -sf android.hardware.security.secureclock-V1-ndk.so $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/android.hardware.security.secureclock-V1-ndk_platform.so; ln -sf android.hardware.security.sharedsecret-V1-ndk.so $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/android.hardware.security.sharedsecret-V1-ndk_platform.so;
# sm84xx-common's twrp/recovery/root is copied AFTER ours (deferred inherit-product
# appends $(COMMON_PATH)/twrp last in TARGET_RECOVERY_DEVICE_DIRS), so its outdated
# keymint .rc overwrites our fixed one. Re-copy ours at recipe time (runs after the
# recovery-root copy) so the keymint HAL starts with rkp-V3 LD_PRELOAD and decryption works.
BOARD_RECOVERY_IMAGE_PREPARE += cp -f $(DEVICE_PATH)/recovery/root/vendor/etc/init/android.hardware.security.keymint-service-qti.rc $(TARGET_RECOVERY_ROOT_OUT)/vendor/etc/init/android.hardware.security.keymint-service-qti.rc;

AERA_POST_DECRYPT_MODULES := "cnss_prealloc.ko cnss_nl.ko wlan_firmware_service.ko cnss_utils.ko icnss2.ko rmnet_perf.ko rmnet_shs.ko rmnet_aps.ko rmnet_offload.ko rmnet_perf_tether.ko rmnet_wlan.ko rmnet_core.ko rmnet_ctl.ko cfg80211.ko gsim.ko ipam.ko qca_cld3_adrastea.ko"

# Kernel-matched Garnet module set. Keep the audio sequence aligned with the
# stock modules.load so the machine card and speaker codec probe reliably.
AERA_LOAD_VENDOR_MODULES := "rproc_qcom_common.ko qcom_q6v5.ko qcom_q6v5_pas.ko qcom_esoc.ko qcom_sysmon.ko qcom_smd.ko qcom_glink_smem.ko qcom_glink.ko pdr_interface.ko qmi_helpers.ko q6_notifier_dlkm.ko spf_core_dlkm.ko audpkt_ion_dlkm.ko gpr_dlkm.ko audio_pkt_dlkm.ko q6_dlkm.ko adsp_loader_dlkm.ko audio_prm_dlkm.ko q6_pdr_dlkm.ko pinctrl_lpi_dlkm.ko swr_dlkm.ko swr_ctrl_dlkm.ko snd_event_dlkm.ko wcd_core_dlkm.ko mbhc_dlkm.ko swr_dmic_dlkm.ko wcd9xxx_dlkm.ko swr_haptics_dlkm.ko stub_dlkm.ko wsa881x_dlkm.ko machine_dlkm.ko lpass_cdc_wsa2_macro_dlkm.ko lpass_cdc_wsa_macro_dlkm.ko lpass_cdc_va_macro_dlkm.ko lpass_cdc_rx_macro_dlkm.ko lpass_cdc_tx_macro_dlkm.ko lpass_cdc_dlkm.ko wsa883x_dlkm.ko wcd938x_dlkm.ko wcd938x_slave_dlkm.ko cs35l43_dlkm.ko aw882xx_dlkm.ko fs19xx_dlkm.ko wcd937x_dlkm.ko wcd937x_slave_dlkm.ko hdmi_dlkm.ko frpc-adsprpc.ko leds-qpnp-vibrator-ldo.ko qcom-hv-haptics.ko qti_battery_charger_main.ko xiaomi_touch.ko goodix_core.ko goodix_fod.ko goodix_health.ko focaltech_fts.ko focaltech_touch.ko cnss_prealloc.ko cnss_utils.ko cnss_nl.ko mi_cnss_statistic.ko cnss_plat_ipc_qmi_svc.ko wlan_firmware_service.ko cnss2.ko qca_cld3_qca6490.ko msm_kgsl.ko"
AERA_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true
#
