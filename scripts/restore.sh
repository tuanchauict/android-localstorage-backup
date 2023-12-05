#!/bin/bash -e
# Restore backed up data to target package
# sh restore.sh <package> <target>

package="$1"
runas="run-as $package"

backup_dir="/sdcard/DevBackup/$package"
restore_target=$2
restore_path="$backup_dir/$restore_target"
tmp=backup_tmp

echo "Restore from $restore_path"

adb shell am force-stop $package

adb shell "dd if=$restore_path" | adb shell "$runas dd of=$restore_target"
adb shell "$runas mkdir -p $tmp"
adb shell "$runas tar -xf $restore_target -C $tmp"
adb shell "$runas rm -f $restore_target"

adb shell "$runas rm -rf shared_prefs" # Clean app's data
adb shell "$runas rm -rf databases" # Clean app's data

adb shell "$runas mkdir -p $tmp/shared_prefs"
adb shell "$runas mkdir -p $tmp/databases"

adb shell "$runas cp -a $tmp/shared_prefs ."
adb shell "$runas cp -a $tmp/databases ."

adb shell "$runas rm -rf $tmp"