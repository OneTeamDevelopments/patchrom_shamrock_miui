#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 34238464 78879fe11a7ecc685963bd9d4389837f379f5545 31723520 26593d99bc1042d772d6f8dcf3da6a54b956a8d7
fi

if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:34238464:78879fe11a7ecc685963bd9d4389837f379f5545; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:31723520:26593d99bc1042d772d6f8dcf3da6a54b956a8d7 EMMC:/dev/block/bootdevice/by-name/recovery 78879fe11a7ecc685963bd9d4389837f379f5545 34238464 26593d99bc1042d772d6f8dcf3da6a54b956a8d7:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
