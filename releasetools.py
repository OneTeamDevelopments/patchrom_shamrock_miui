import common
import edify_generator
import os

def ModifyBegin(edify):
  edify.script[0] = \
  '''ifelse(is_mounted("/system"), unmount("/system"));
ifelse(is_mounted("/data"), unmount("/data"));
ui_print("******************************************");
ui_print("* MIUI 8 For GM 5+ One Team | one-teams.com");
ui_print("*");
ui_print("* Powered By @The Punisher");
ui_print("* MIUI Yukleniyor...");
ui_print("******************************************");\n''' + edify.script[0]

def PushMagisk(input_zip, output_zip, script):
    data = input_zip.read("META/magisk.zip")
    common.ZipWriteStr(output_zip, "magisk/magisk.zip", data)

def InstallMagisk(script):
  script.AppendExtra("package_extract_dir(\"magisk\", \"/tmp/magisk\");")
  script.AppendExtra("run_program(\"/tmp/busybox\", \"unzip\", \"/tmp/magisk/magisk.zip\", \"META-INF/com/google/android/*\", \"-d\", \"/tmp/magisk\");")
  script.AppendExtra("run_program(\"/sbin/sh\", \"/tmp/magisk/META-INF/com/google/android/update-binary\", \"dummy\", \"1\", \"/tmp/magisk/magisk.zip\");")

def RemoveOemApps(script):
  script.AppendExtra("mount(\"ext4\", \"EMMC\", \"/dev/block/bootdevice/by-name/oem\", \"/oem\");")
  script.AppendExtra("delete_recursive(\"/oem/app\");")

def FullOTA_InstallEnd(info):
    edify = info.script
    ModifyBegin(edify)	
    script_temp = edify_generator.EdifyGenerator(3, info.script.info)
    PushMagisk(info.input_zip, info.output_zip, script_temp)
    InstallMagisk(edify)
    RemoveOemApps(edify)
