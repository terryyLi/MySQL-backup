#!/bin/bash
#----------------------------------------
#----------------------------------------
#----------------------------------------


source <changeme> # path for variables.sh

USER=${MYSQL_USER}       # MySQL User
PASSWORD=${MYSQL_PASSWORD} # MySQL Password
DAYS_TO_KEEP=${MYSQL_DAYS_TO_KEEP}   # 0 to keep forever
GZIP=${MYSQL_GZIP}            # 1 = Compress / 0 = not to compress 
BACKUP_PATH=${MYSQL_BACKUP_PATH} # your backup path
OPT=${MYSQL_OPT} #options

# Create the backup folder
if [ ! -d $BACKUP_PATH ]; then
  mkdir -p $BACKUP_PATH
fi

# Get list of database names
databases=`mysql -u $USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "|" | grep -v Database`

for db in $databases; do

  if [ $db == 'information_schema' ] || [ $db == 'performance_schema' ] || [ $db == 'mysql' ] || [ $db == 'sys' ]; then
    echo "Skipping database: $db"
    continue
  fi
  
  if [ "$GZIP" -eq 0 ] ; then
    echo "Backing up database: $db without compression"      
    # FOO="$BACKUP_PATH/terrydump_$db-`date +\%Y_\%m_\%d`.sql"
    mysqldump -u $USER --password=$PASSWORD  --databases $db $OPT > $BACKUP_PATH/$db-`date +\%Y_\%m_\%d`.sql
    
  else
    echo "Backing up database: $db with compression"
    # FOO="$BACKUP_PATH/terrydump_$db-`date +\%Y_\%m_\%d`.sql.gz"
    mysqldump -u $USER --password=$PASSWORD  --databases $db $OPT | gzip -c > $BACKUP_PATH/$db-`date +\%Y_\%m_\%d`.sql.gz
    # mysqldump -u $USER --password=$PASSWORD --databases $db | gzip -c > $BACKUP_PATH/$date-$db.gz
  fi
done

# Delete old backups
if [ "$DAYS_TO_KEEP" -gt 0 ] ; then
  echo "Deleting backups older than $DAYS_TO_KEEP days"
  find $BACKUP_PATH/* -mtime +$DAYS_TO_KEEP -exec rm {} \;
fi
