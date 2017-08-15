#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 34238464 4dcc9717d1c7a1a7bb5a8e457ba8131f19ad1462 31723520 7534b167c7ee19923f92d4d79b4e070d617c7715
fi

if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:34238464:4dcc9717d1c7a1a7bb5a8e457ba8131f19ad1462; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:31723520:7534b167c7ee19923f92d4d79b4e070d617c7715 EMMC:/dev/block/bootdevice/by-name/recovery 4dcc9717d1c7a1a7bb5a8e457ba8131f19ad1462 34238464 7534b167c7ee19923f92d4d79b4e070d617c7715:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
