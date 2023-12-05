#!/bin/bash -e
# List all backups
# sh all-backup.sh <package>

package="$1"
backup_dir="/sdcard/DevBackup/$package"

adb shell "ls $backup_dir"
