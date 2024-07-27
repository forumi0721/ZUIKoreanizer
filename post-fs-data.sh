#!/bin/sh

MODDIR=${0%/*}

{
	echo "[Device Compatibility Check] Start"

	fingerprint=$(getprop ro.build.fingerprint)
	if [ "$fingerprint" != "Lenovo/TB371FC_PRC/TB371FC:13/TKQ1.221013.002/ZUI_15.0.664_240414_PRC:user/release-keys" ]; then
		echo "이 모듈은 Xiaoxin Pad Pro 12.7 664 버전만 지원합니다. 다른 버전은 지원되지 않습니다."
		echo "This module only supports Xiaoxin Pad Pro 12.7 version 664. Other versions are not supported."

		echo "Rolling back /system/framework..."
		rm -rf $MODDIR/system/framework
		echo "/system/framework has been rolled back."
	else
		echo "Device compatibility check passed."
	fi

	echo "[Device Compatibility Check] End"
} > /data/local/tmp/ZUIKoreanizer-post-fs-data.log 2>&1

