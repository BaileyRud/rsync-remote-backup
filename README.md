rsync Remote-Backup
===================
Bash script for making remote backups of linux servers using SSH and rsync. The script creates incremental backups for less storage-usage and transfer-compression.
A full backup of all files is created at the first of each month, after that all daily backups are incremental (with hardlinks to the full-backup, so each directory contains all files, but each file is only stored once).

Usage
=====
Important:  rsync and SSH have to be installed on both servers

Customize the first 2 variables:
* BACKUP_DIR = directory which you want to backup on remote-server)
* BACKUP_SERVERDIR = directory to store the backups on your local/backup server)

After that, you need to customize the SSH configuration. It's recommended to use public-key-authentication for connecting, because it's easier to manage than passwords. Also, you should not connect with root - for security reasons, the best option is to create a normal user and give them the right to execute rsync with sudo:
```
autobackup      ALL=(ALL:ALL) NOPASSWD: /usr/bin/rsync
```

License
=======
GNU GENERAL PUBLIC LICENSE
Version 3, 29 June 2007
(See LICENSE file)
