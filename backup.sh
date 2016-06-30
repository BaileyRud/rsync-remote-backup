#!/bin/bash

BACKUP_DIR="/var/www"
BACKUP_SERVERDIR="/var/backups/server1"

DATE=`date +%Y-%m-%d`
DATE_DAY=`date +%d`
DATE_YEARMONTH=`date +%Y-%m`

# get backup type (full or incremental)
if [ "$DATE_DAY" == "01" ]
	then
		BACKUP_TYPE=1
		BACKUP_FINALDIR=$BACKUP_SERVERDIR"/full_"$DATE
	else
		BACKUP_TYPE=2
		BACKUP_FINALDIR=$BACKUP_SERVERDIR"/incr_"$DATE
		BACKUP_ORIGINDIR=$BACKUP_SERVERDIR"/full_"$DATE_YEARMONTH"-01"
		if [ ! -d "$BACKUP_ORIGINDIR" ]; then
			BACKUP_ORIGINDIR=$BACKUP_SERVERDIR"/full_"$DATE_YEARMONTH"-auto"
			if [ ! -d "$BACKUP_ORIGINDIR" ]; then
				BACKUP_TYPE=1
				BACKUP_FINALDIR=$BACKUP_SERVERDIR"/full_"$DATE_YEARMONTH"-auto"
			fi
		fi
fi


# perform backup
if [ -d $BACKUP_SERVERDIR ]; then
	if [ $BACKUP_TYPE == 1 ]
		then
			rsync --rsync-path="sudo rsync" -arpzbe "ssh -i /path/to/ssh_private_key -p 22" autobackup@127.0.0.1:$BACKUP_DIR $BACKUP_FINALDIR --backup-dir=$BACKUP_FINALDIR
			echo "Full-Backup successfully stored in $BACKUP_FINALDIR"
		else
			rsync --rsync-path="sudo rsync" -acrpzbe "ssh -i /path/to/ssh_private_key -p 22" autobackup@127.0.0.1:$BACKUP_DIR $BACKUP_FINALDIR --backup-dir=$BACKUP_FINALDIR --link-dest=$BACKUP_ORIGINDIR
			echo "Incremental-Backup successfully stored in $BACKUP_FINALDIR"
	fi
fi
