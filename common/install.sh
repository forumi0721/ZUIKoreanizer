# Device Compatibility Check
ui_print "==> Device Compatibility Check"
fingerprint=$(getprop ro.build.fingerprint)
if [ "${fingerprint}" != "Lenovo/TB371FC_PRC/TB371FC:13/TKQ1.221013.002/ZUI_15.0.664_240414_PRC:user/release-keys" ]; then
    ui_print "이 모듈은 Xiaoxin Pad Pro 12.7 664 버전만 지원합니다. 다른 버전은 지원되지 않습니다."
    ui_print "This module only supports Xiaoxin Pad Pro 12.7 version 664. Other versions are not supported."
    abort "Installation aborted due to incompatible device."
fi
ui_print "Device compatibility check passed."
ui_print ""


# Disclaimer
ui_print "==> Disclaimer"
ui_print "Warning: This script may modify system files. By proceeding, you accept that the authors of this script are not responsible for any damage or issues that may occur to your device. Use at your own risk."
ui_print "경고: 이 스크립트는 시스템 파일을 수정할 수 있습니다. 계속 진행하면 이 스크립트의 작성자는 장치에 발생할 수 있는 손상이나 문제에 대해 책임지지 않는다는 것에 동의하는 것입니다. 사용에 따른 책임은 본인에게 있습니다."
ui_print ""
ui_print "Note: During installation, Magisk may force-close once due to enabling GMS. You will need to reinstall for proper operation."
ui_print "참고: 설치 중에 Magisk가 GMS 활성화로 인해 한 번 강제 종료될 수 있습니다. 정상적인 작동을 위해 다시 설치해야 합니다."
ui_print ""
ui_print "Do you want to continue?"
ui_print " - Vol Up   = Yes"
ui_print " - Vol Down = No"
if ! chooseport; then
    abort "Installation aborted by the user."
fi
ui_print ""


# Preparation Step
ui_print "==> Preparation Step"
ui_print "Preparation is being configured..."

# Detect device
device=$(getprop ro.product.device)
device_l=$(echo "${device}" | tr 'A-Z' 'a-z')

# Detect root environment
environment=
system_path=
system_ext_path=
product_path=
vendor_path=
if [ -f "/data/adb/magisk/magiskinit" ]; then
    environment="magisk"
    system_path=$MODPATH/system
    system_ext_path=$MODPATH/system/system_ext
    product_path=$MODPATH/system/product
    vendor_path=$MODPATH/system/vendor
else
    if [ -d "/data/adb/ksu/bin/ksud" ]; then
        environment="kernelsu"
    elif [ -f "/data/adb/ap/bin/apd" ]; then
        environment="apatch"
    else
        echo "unknown"
    fi
    system_path=$MODPATH/system
    system_ext_path=$MODPATH/system_ext
    product_path=$MODPATH/product
    vendor_path=$MODPATH/vendor
fi

ui_print "Preparation has been configured successfully."
ui_print ""


# Initialize step counter
STEP=0

# Korean Patch Installation
STEP=$((STEP + 1))
ui_print "==> Step ${STEP}: Korean Patch Installation"
ui_print " Applies Korean patch."
ui_print " 한국어 패치를 적용합니다."
ui_print "Do you want to apply the Korean patch?"
ui_print " - Vol Up   = Yes"
ui_print " - Vol Down = No"
if chooseport; then
    korean_patch_choice="Y"
else
    korean_patch_choice="N"
fi
ui_print ""

# Google Play Activation
STEP=$((STEP + 1))
ui_print "==> Step ${STEP}: Google Play Activation"
ui_print " Activates Google Play Services and installs Play Store."
ui_print " 구글 플레이 서비스를 활성화하고 플레이스토어를 설치합니다."
ui_print "Do you want to activate Google Play?"
ui_print " - Vol Up   = Yes"
ui_print " - Vol Down = No"
if chooseport; then
    google_play_choice="Y"
else
    google_play_choice="N"
fi
ui_print ""

# Disable/Uninstall Chinese Apps
STEP=$((STEP + 1))
ui_print "==> Step ${STEP}: Disable/Uninstall Chinese Apps"
ui_print " Disables or uninstalls Chinese apps."
ui_print " 중국 앱을 비활성화하거나 제거합니다."
ui_print "Do you want to disable/uninstall Chinese apps?"
ui_print " - Vol Up   = Yes"
ui_print " - Vol Down = No"
if chooseport; then
    chinese_apps_debloat_choice="Y"
    ui_print ""
    ui_print "Remove all possible apps?"
    ui_print " 가능한 모든 앱을 삭제하시겠습니까?"
    ui_print " - Vol Up   = Yes"
    ui_print " - Vol Down = No"
    if chooseport; then
        chinse_app_debloat_all_choice="Y"
    else
        chinse_app_debloat_all_choice="N"
    fi
else
    chinese_apps_debloat_choice="N"
fi
ui_print ""

# Force Apply Widevine L3 for DRM Playback
STEP=$((STEP + 1))
ui_print "==> Step ${STEP}: Force Apply Widevine L3 for DRM Playback"
ui_print " Applies Widevine L3 for DRM content playback."
ui_print " DRM 콘텐츠 재생을 위해 Widevine L3를 적용합니다."
ui_print "Do you want to apply Widevine L3?"
ui_print " - Vol Up   = Yes"
ui_print " - Vol Down = No"
if chooseport; then
    widevine_choice="Y"
else
    widevine_choice="N"
fi
ui_print ""

# Pen Service Activation
STEP=$((STEP + 1))
ui_print "==> Step ${STEP}: Pen Service Activation"
ui_print " Activates Pen Service."
ui_print " 펜 서비스를 활성화합니다."
ui_print "Do you want to activate Pen Service?"
ui_print " - Vol Up   = Yes"
ui_print " - Vol Down = No"
if chooseport; then
    pen_service_choice="Y"
else
    pen_service_choice="N"
fi
ui_print ""

## ROW Version Switch
#STEP=$((STEP + 1))
#ui_print "==> Step ${STEP}: ROW Version Switch"
#ui_print " Switches device to Rest of the World (ROW) version. The default is People's Republic of China (PRC)."
#ui_print " 기기를 Rest of the World (ROW) 버전으로 전환합니다. 기본값은 People’s Republic of China (PRC)입니다."
#ui_print "Do you want to switch to the ROW version?"
#ui_print " - Vol Up   = Yes"
#ui_print " - Vol Down = No"
#if chooseport; then
#    row_version_choice="Y"
#else
#    row_version_choice="N"
#fi
#ui_print ""

# Keyboard Mapping Change
STEP=$((STEP + 1))
ui_print "==> Step ${STEP}: Keyboard Mapping Change"
ui_print " Applies keyboard mapping change for BACK->ESC, DELETE->BACK."
ui_print " 순정 키보드 BACK->ESC, DELETE->BACK 맵핑 변경을 적용합니다."
ui_print "Do you want to apply the keyboard mapping change?"
ui_print " - Vol Up   = Yes"
ui_print " - Vol Down = No"
if chooseport; then
    keyboard_mapping_choice="Y"
else
    keyboard_mapping_choice="N"
fi
ui_print ""


# Summary of Choices
ui_print "==> Summary of Choices"
if [ ! -z "${korean_patch_choice}" ]; then
    ui_print "$(printf " %-50s : %s\n" "Korean Patch Installation" "${korean_patch_choice}")"
fi
if [ ! -z "${google_play_choice}" ]; then
    ui_print "$(printf " %-50s : %s\n" "Google Play Activation" "${google_play_choice}")"
fi
if [ ! -z "${chinese_apps_debloat_choice}" ]; then
    ui_print "$(printf " %-50s : %s\n" "Disable/Uninstall Chinese Apps" "${chinese_apps_debloat_choice}")"
    ui_print "$(printf " %-50s : %s\n" " - Remove basic apps" "Y")"
    ui_print "$(printf " %-50s : %s\n" " - Remove advance apps" "${chinse_app_debloat_all_choice}")"
fi
if [ ! -z "${widevine_choice}" ]; then
    ui_print "$(printf " %-50s : %s\n" "Force Apply Widevine L3 for DRM Playback" "${widevine_choice}")"
fi
if [ ! -z "${pen_service_choice}" ]; then
    ui_print "$(printf " %-50s : %s\n" "Pen Service Activation" "${pen_service_choice}")"
fi
if [ ! -z "${row_version_choice}" ]; then
    ui_print "$(printf " %-50s : %s\n" "ROW Version Switch" "${row_version_choice}")"
fi
if [ ! -z "${keyboard_mapping_choice}" ]; then
    ui_print "$(printf " %-50s : %s\n" "Keyboard Mapping Change" "${keyboard_mapping_choice}")"
fi
ui_print ""
ui_print "Are these choices correct?"
ui_print " - Vol Up   = Yes"
ui_print " - Vol Down = No"
if ! chooseport; then
    abort "Installation aborted by the user."
fi
ui_print ""


# Configuration based on choices
ui_print "==> Applying configurations based on your choices"
ui_print ""

# Initialize step counter
STEP=0

# Korean Patch Installation
if [ ! -z "${korean_patch_choice}" ]; then
    STEP=$((STEP + 1))
    ui_print "==> Step ${STEP}: Korean Patch Installation"
    if [ "${korean_patch_choice}" == "Y" ]; then
        ui_print "Installing Korean Patch..."
        mkdir -p ${system_path}/framework
        for framework in $MODPATH/common/files/stonecold-framework/*.jar
        do
            ui_print " - $(basename "${framework}")"
            cp -a ${framework} ${system_path}/framework/
        done
        mkdir -p ${product_path}/overlay
        for rro in $MODPATH/common/files/stonecold-rro/*.apk
        do
            ui_print " - $(basename "${rro}")"
            bn=$(basename "${rro}")
            to_name=StoneColdOverlay${bn/.apk/}.apk
            if [ "${bn}" = "framework-res.apk" ]; then
                to_name=StoneColdOverlayFrameworkRes.apk
            fi
            cp -a ${rro} ${product_path}/overlay/${to_name}
        done
        ui_print "Korean patch installation complete."
    else
        ui_print "Korean patch installation skipped."
    fi
    ui_print ""
fi

# Google Play Activation
STEP=$((STEP + 1))
if [ ! -z "${google_play_choice}" ]; then
    ui_print "==> Step ${STEP}: Google Play Activation"
    if [ "${google_play_choice}" == "Y" ]; then
        ui_print "Activating Google Play..."
        #pm list packages -d | grep -E 'com.google.android.gsf|com.android.vending|com.google.android.partnersetup|com.google.android.printservice.recommendation|com.google.android.ext.shared|com.google.android.onetimeinitializer|com.google.android.configupdater|com.google.android.gms|com.android.vending' | sed -e 's/^.*package://g' | while read -r pkg
        pm list packages -d | grep -E 'com.google.android.gsf|com.android.vending|com.google.android.printservice.recommendation|com.google.android.ext.shared|com.google.android.onetimeinitializer|com.google.android.configupdater|com.google.android.gms|com.android.vending' | sed -e 's/^.*package://g' | while read -r pkg
        do
            ui_print " - ${pkg}"
            pm enable ${pkg}
        done
        sleep 2
        if [ "$(pm path com.android.vending)" = "package:/product/priv-app/GooglePlayServicesUpdater/GooglePlayServicesUpdater.apk" ]; then
            ui_print " - com.android.vending"
            if [ "${environment}" = "apatch" ]; then
                pm install -r $MODPATH/common/files/stonecold-playstore/com.android.vending.apk
            else
                mkdir -p ${product_path}/priv-app/GooglePlay
                cp $MODPATH/common/files/stonecold-playstore/com.android.vending.apk ${product_path}/priv-app/GooglePlay/GooglePlay.apk
                if [ "${environment}" = "magisk" ]; then
                    mkdir -p ${product_path}/priv-app/GooglePlayServicesUpdater
                    touch ${product_path}/priv-app/GooglePlayServicesUpdater/.replace
                else
                    mkdir -p ${product_path}/priv-app
                    mknod ${product_path}/priv-app/GooglePlayServicesUpdater c 0 0
                    #touch ${product_path}/priv-app/GooglePlayServicesUpdater
                    #chmod 000 ${product_path}/priv-app/GooglePlayServicesUpdater
                fi
            fi
        fi
        ui_print " - /product/etc/permissions"
        mkdir -p ${product_path}/etc/permissions
        cp $MODPATH/common/files/stonecold-playstore/services.cn.google.xml ${product_path}/etc/permissions/
        ui_print "Google Play activation complete."
    else
        ui_print "Google Play activation skipped."
    fi
    ui_print ""
fi

# Disable/Uninstall Chinese Apps
if [ ! -z "${chinese_apps_debloat_choice}" ]; then
    STEP=$((STEP + 1))
    ui_print "==> Step ${STEP}: Disable/Uninstall Chinese Apps"
    if [ "${chinese_apps_debloat_choice}" == "Y" ]; then
        #User Packages (visible)
        ui_print "Disabling/Uninstalling Chinese Apps..."
        pm list packages -3 | grep -E 'cn.wps.moffice_eng|com.baidu.netdisk|com.lenovo.club.app|com.lenovo.hyperengine|com.lenovo.menu_assistant|com.newskyer.draw|com.qiyi.video.pad|com.sina.weibo|com.smile.gifmaker|com.sohu.inputmethod.sogou.oem|com.tencent.qqmusic|com.zui.calculator|com.zui.calendar|com.zui.calendar.overlay.avengers|com.zui.calendar.overlay.blue|com.zui.calendar.overlay.golden|com.zui.calendar.overlay.grace|com.zui.calendar.overlay.mains|com.zui.calendar.overlay.mostbeautiful|com.zui.calendar.overlay.paintingr|com.zui.calendar.overlay.pink|com.zui.calendar.overlay.superhero|com.zui.recorder|com.zui.weather|io.moreless.tide|net.huanci.hsjpro' | sed -e 's/^.*package://g' | while read -r pkg
        do
            ui_print " - ${pkg} (preinstall)"
            pm uninstall ${pkg}
        done

        #System Packages
        #com.zui.gallery,/system/priv-app/ZuiGallery/ZuiGallery.apk - 배경화면 설정을 위해 필요
        #com.zui.deskclock,/system/app/ZuiAlarm/ZuiAlarm.apk - 일부 앱의 참조
        #com.zui.deskclock.overlay.avengers,/product/overlay/ZuiAlarmOverlayavengers.apk - 일부 앱의 참조
        #com.zui.deskclock.overlay.blue,/product/overlay/ZuiAlarmOverlayblue.apk - 일부 앱의 참조
        #com.zui.deskclock.overlay.golden,/product/overlay/ZuiAlarmOverlaygolden.apk - 일부 앱의 참조
        #com.zui.deskclock.overlay.grace,/product/overlay/ZuiAlarmOverlaygrace.apk - 일부 앱의 참조
        #com.zui.deskclock.overlay.lime,/product/overlay/ZuiAlarmOverlaylime.apk - 일부 앱의 참조
        #com.zui.deskclock.overlay.mostbeautiful,/product/overlay/ZuiAlarmOverlaymostbeautiful.apk - 일부 앱의 참조
        #com.zui.deskclock.overlay.paintingr,/product/overlay/ZuiAlarmOverlaypaintingr.apk - 일부 앱의 참조
        #com.zui.deskclock.overlay.pink,/product/overlay/ZuiAlarmOverlaypink.apk - 일부 앱의 참조
        #com.zui.deskclock.overlay.superhero,/product/overlay/ZuiAlarmOverlaysuperhero.apk - 일부 앱의 참조
        #com.zui.notes,/system/priv-app/ZuiNotes/ZuiNotes.apk - 스타일러스 쓸때 참조
        for pkg_path in com.lenovo.browser.hd,/system/priv-app/ZuiBrowser/ZuiBrowser.apk com.lenovo.leos.appstore,/system/priv-app/LenovoStore/LenovoStore.apk com.lenovo.leos.cloud.sync,/system/priv-app/XuiEasySync/XuiEasySync.apk com.zui.clone,/system/priv-app/ZuiClone/ZuiClone.apk com.zui.contacts,/system/priv-app/ZuiContacts/ZuiContacts.apk com.zui.filemanager,/system/app/ZuiFileManager/ZuiFileManager.apk com.baidu.map.location,/system/priv-app/BaiduNetworkLocation/BaiduNetworkLocation.apk com.google.android.partnersetup,/product/priv-app/GooglePartnerSetup/GooglePartnerSetup.apk com.lenovo.lfh.tianjiao.tablet,/system/priv-app/LFHTianjiaoTablet/LFHTianjiaoTablet.apk com.lenovo.udcplatform,/system/priv-app/UDCplatform/UDCplatform.apk com.zui.xlog,/system/priv-app/ZuiXlog/ZuiXlog.apk com.tblenovo.center,/system/priv-app/TabletVantage/TabletVantage.apk
        do
            pkg=${pkg_path/,*/}
            path=${pkg_path/*,/}
            pm_path="$(pm path "${pkg}")"
            if [ -z "${pm_path}" ]; then
                continue
            fi
            ui_print " - ${pkg} (basic)"
            if [ "${pm_path}" != "${pm_path/package:\/data/}" ]; then
                pm uninstall ${pkg}
            fi

            pm_path="$(pm path "${pkg}")"
            if [ -z "${pm_path}" ]; then
                continue
            fi
            pm uninstall --user 0 ${pkg}
            pm disable-user --user 0 ${pkg}
        done

        if [ "${chinse_app_debloat_all_choice}" == "Y" ]; then
            #System Packages
            #com.zui.wallpapercropper,/system/priv-app/ZuiGalleryWallpaperCropper/ZuiGalleryWallpaperCropper.apk - 배경화면 설정을 위해 필요
            #com.zui.wallpapersetting,/system/priv-app/ZuiWallpaperSetting/ZuiWallpaperSetting.apk - 개인 사용자 지정 사용을 위해 필요
            #com.zui.homesettings,/system/priv-app/ZuiHomeSettings/ZuiHomeSettings.apk - 개인 사용자 지정 사용을 위해 필요
            #com.zui.safecenter,/system/priv-app/ZuiSecurity/ZuiSecurity.apk - Privacy space 등을 쓰기 위해 필요
            #com.zui.safecenter.overlay.avengers,/product/overlay/ZuiSecurityOverlayavengers.apk - Privacy space 등을 쓰기 위해 필요
            #com.zui.safecenter.overlay.blue,/product/overlay/ZuiSecurityOverlayblue.apk - Privacy space 등을 쓰기 위해 필요
            #com.zui.safecenter.overlay.golden,/product/overlay/ZuiSecurityOverlaygolden.apk - Privacy space 등을 쓰기 위해 필요
            #com.zui.safecenter.overlay.grace,/product/overlay/ZuiSecurityOverlaygrace.apk - Privacy space 등을 쓰기 위해 필요
            #com.zui.safecenter.overlay.lime,/product/overlay/ZuiSecurityOverlaylime.apk - Privacy space 등을 쓰기 위해 필요
            #com.zui.safecenter.overlay.mostbeautiful,/product/overlay/ZuiSecurityOverlaymostbeautiful.apk - Privacy space 등을 쓰기 위해 필요
            #com.zui.safecenter.overlay.paintingr,/product/overlay/ZuiSecurityOverlaypaintingr.apk - Privacy space 등을 쓰기 위해 필요
            #com.zui.safecenter.overlay.pink,/product/overlay/ZuiSecurityOverlaypink.apk - Privacy space 등을 쓰기 위해 필요
            #com.zui.safecenter.overlay.superhero,/product/overlay/ZuiSecurityOverlaysuperhero.apk - Privacy space 등을 쓰기 위해 필요
            for pkg_path in android.autoinstalls.config.Lenovo.tablet,/system/app/LenovoPAI/LenovoPAI.apk com.lenovo.lsf,/system/priv-app/LenovoID/LenovoID.apk com.lenovo.lsf.device,/system/priv-app/LSF-Device-Phone/LSF-Device-Phone.apk com.lenovo.tbengine,/system/priv-app/UDSEngine/UDSEngine.apk com.lenovo.weathercenter,/system/priv-app/WeatherCenter/WeatherCenter.apk com.motorola.readyforsignature.app,/system/priv-app/ReadyForSignatureApp/ReadyForSignatureApp.apk com.tblenovo.tabpushout,/system/priv-app/TabletPushOut/TabletPushOut.apk com.zui.davdroid,/system/priv-app/ZuiContactsDAV/ZuiContactsDAV.apk com.zui.engine,/system/priv-app/ZuiServiceEngine/ZuiServiceEngine.apk com.zui.launchersdk,/system/priv-app/ZuiLauncherSDK/ZuiLauncherSDK.apk com.zui.udevice,/system/priv-app/ZuiUDevice/ZuiUDevice.apk com.lenovo.levoice.caption,/system/priv-app/LeVoiceCaptionApp/LeVoiceCaptionApp.apk
            do
                pkg=${pkg_path/,*/}
                path=${pkg_path/*,/}
                pm_path="$(pm path "${pkg}")"
                if [ -z "${pm_path}" ]; then
                    continue
                fi
                ui_print " - ${pkg} (advance)"
                if [ "${pm_path}" != "${pm_path/package:\/data/}" ]; then
                    pm uninstall ${pkg}
                fi

                pm_path="$(pm path "${pkg}")"
                if [ -z "${pm_path}" ]; then
                    continue
                fi
                pm uninstall --user 0 ${pkg}
                pm disable-user --user 0 ${pkg}
            done
        fi
        ui_print "Chinese apps disable/uninstall complete."
    else
        ui_print "Chinese apps disable/uninstall skipped."
    fi
    ui_print ""
fi

# Force Apply Widevine L3 for DRM Playback
if [ ! -z "${widevine_choice}" ]; then
    STEP=$((STEP + 1))
    ui_print "==> Step ${STEP}: Force Apply Widevine L3 for DRM Playback"
    if [ "${widevine_choice}" == "Y" ]; then
        ui_print "Applying Widevine L3..."
        if [ -e /vendor/lib/liboemcrypto.so -o -e /system/vendor/lib/liboemcrypto.so ]; then
            ui_print " - /vendor/lib/liboemcrypto.so"
            mkdir -p ${vendor_path}/lib
            touch ${vendor_path}/lib/liboemcrypto.so
        fi
        if [ -e /vendor/lib64/liboemcrypto.so -o -e /system/vendor/lib64/liboemcrypto.so ]; then
            ui_print " - /vendor/lib64/liboemcrypto.so"
            mkdir -p ${vendor_path}/lib64
            touch ${vendor_path}/lib64/liboemcrypto.so
        fi
        ui_print "Widevine L3 applied."
    else
        ui_print "Widevine L3 application skipped."
    fi
    ui_print ""
fi

# Pen Service Activation
if [ ! -z "${pen_service_choice}" ]; then
    STEP=$((STEP + 1))
    ui_print "==> Step ${STEP}: Pen Service Activation"
    if [ "${pen_service_choice}" == "Y" ]; then
        ui_print "Activating Pen Service..."
        ui_print " - system.prop"
        cat $MODPATH/common/files/stonecold-penservice/system.prop >> $MODPATH/system.prop
        ui_print "Pen Service activation complete."
    else
        ui_print "Pen Service activation skipped."
    fi
    ui_print ""
fi

# ROW Version Switch
if [ ! -z "${row_version_choice}" ]; then
    STEP=$((STEP + 1))
    ui_print "==> Step ${STEP}: ROW Version Switch"
    if [ "${row_version_choice}" == "Y" ]; then
        ui_print "Switching to ROW version..."
        ui_print " - system.prop"
        cat $MODPATH/common/files/stonecold-row/system.prop >> $MODPATH/system.prop
        ui_print " - /system/etc/smartrotate/sw-config.xml"
        mkdir -p ${system_path}/etc/smartrotate
        cat $MODPATH/common/files/stonecold-row/sw-config.xml >> ${system_path}/etc/smartrotate/
        ui_print "ROW version switch complete."
    else
        ui_print "ROW version switch skipped."
    fi
    ui_print ""
fi

# Keyboard Mapping Change
if [ ! -z "${keyboard_mapping_choice}" ]; then
    STEP=$((STEP + 1))
    ui_print "==> Step ${STEP}: Keyboard Mapping Change"
    if [ "${keyboard_mapping_choice}" == "Y" ]; then
        ui_print "Applying keyboard mapping change..."
        ui_print " - /system/usr/keylayout/Vendor_17ef_Product_6175.kl"
        mkdir -p ${system_path}/usr/keylayout
        cp -a $MODPATH/common/files/stonecold-keylayout/Vendor_17ef_Product_6175.kl ${system_path}/usr/keylayout/
        ui_print "Keyboard mapping change applied."
    else
        ui_print "Keyboard mapping change skipped."
    fi
    ui_print ""
fi


# Finalization Step
ui_print "==> Finalization Step"
ui_print "Finalizing the setup..."
rm -rf $MODPATH/zygisk
chmod 755 $MODPATH/*.sh
chmod 755 $MODPATH/Makefile
if [ "${korean_patch_choice}" == "Y" ]; then
    settings put system system_locales 'ko-KR'
    settings put global device_name "Xiaoxin Pad Pro 12.7"
    rm -rf /data/dalvik-cache/arm64/system@framework@*
fi
ui_print "Setup has been finalized successfully."
ui_print ""

# Additional Information
ui_print "==> Additional Information"
ui_print " To ensure all features work correctly, please install the Xposed module ZuiTweak."
ui_print " 모든 기능이 정상적으로 동작하려면 Xposed 모듈 ZuiTweak을 설치해야 합니다."
ui_print ""

# Configuration complete
ui_print "All configurations have been applied successfully."
ui_print "모든 설정이 성공적으로 적용되었습니다."

