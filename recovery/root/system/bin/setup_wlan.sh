#!/system/bin/sh
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2026 The OrangeFox Recovery Project
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

load_the_modules() {
	local lib=/vendor_dlkm/lib/modules;
	local dirs="/tmp/vendor/lib/modules /tmp/vendor_dlkm/lib/modules /vendor/lib/modules/1.1";
	local found="";
	for i in $dirs
	do
		if [ -d $i ]; then
			ln -s $i $lib;
			found=$i;
			break;
		fi
	done

	[ -z "$found" ] && found=/vendor/lib/modules/1.1;

	if [ ! -e $lib ]; then
		mkdir -p /vendor_dlkm/lib/;
		ln -s $found $lib;
	fi

	local mods="rmnet_perf.ko rmnet_shs.ko rmnet_aps.ko rmnet_offload.ko rmnet_perf_tether.ko rmnet_core.ko rmnet_wlan.ko rmnet_sch.ko rmnet_ctl.ko ipa_fmwk.ko qmi_helpers.ko wlan_firmware_service.ko";
	for i in $mods
	do
		echo "DEBUG: mounting $i ..." >> /tmp/recovery.log;
		modprobe -d $found $i; #  &> /dev/null;
	done
}

# --- #
load_the_modules;
exit 0;
#
