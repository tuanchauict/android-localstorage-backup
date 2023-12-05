# Usage

1. Choose your app package
2. Backup
    ```
    sh scripts/backup.sh <package> [suffix]
    ```
    `suffix` is the additional information used for naming the backup (UNIX file format)
3. Restore
    ```
    sh scripts/restore.sh <package> <target>
    ```
    `target` is the full file name of the backup. Check List all to know the backup in the store
4. List all
    ```
    sh scripts/all-backup.sh <package>
    ```