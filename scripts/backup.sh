#!/bin/bash -e
# Backup data from target package
# sh backup.sh <package> [suffix]

package="$1"
runas="run-as $package"

backup_dir="sdcard/DevBackup/$package"

suffix="$2"

backup_time=$(date +%F_%H-%M-%S)
backup_version=$(adb shell dumpsys package $package | grep versionName | sed -E "s/    versionName=//")
echo "Backup version:===$backup_version==="
dash="_"
separator="__version_"
backup_name="$backup_time$separator$backup_version"

if [[ -n "$suffix" ]]; then
  backup_name="$backup_name$dash$suffix"
fi

backup_path="$backup_dir/$backup_name"

echo Backup to "$backup_path"

# Create backup dir
adb shell "mkdir -p $backup_dir"

tmp=backup_tmp
adb shell "$runas mkdir -p backup_tmp"

# TODO: Allow customization the backup dirs
adb shell "$runas cp -a shared_prefs $tmp"
adb shell "$runas cp -a databases $tmp"
adb shell "$runas tar -czf $backup_name -C $tmp ."
adb shell "$runas rm -rf $tmp" # Clean tmp

adb shell "$runas dd if=$backup_name" | adb shell "dd of=$backup_path" >/dev/null 2>&1
adb shell "$runas rm -f $backup_name"