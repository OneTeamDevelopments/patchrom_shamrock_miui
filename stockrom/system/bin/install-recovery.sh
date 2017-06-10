#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 34199552 9e6baa126732777f023973450c9759d1c0fb29ea 31684608 ec9302bd1cc7b807ad9306d897f1d34dca2f71f1
fi

if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:34199552:9e6baa126732777f023973450c9759d1c0fb29ea; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:31684608:ec9302bd1cc7b807ad9306d897f1d34dca2f71f1 EMMC:/dev/block/bootdevice/by-name/recovery 9e6baa126732777f023973450c9759d1c0fb29ea 34199552 ec9302bd1cc7b807ad9306d897f1d34dca2f71f1:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
