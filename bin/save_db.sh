#!/bin/bash
# example de crontab
##mm     hh      DD  MM   W    /path/progam [--option]...  ( W = weekday: 0-6 [Sun=0] )
# 0   10,13,16   *   *   1-5   /home/Sauvegarde/script/save_db.sh

# configuration de l'accès à la base de données
# Liste des bases à sauvegarder
DBNAMES="asur datastore"
HOST="--host=localhost"
USER="--user=root"
# si vous n'avez pas de mot de passe commenter la ligne suivante et décommenter la suivante
#PASSWORD="--password=monmotdepasse"
PASSWORD=""
PORT="--port=3306"
# vous pouvez changer ces valeurs elles sont optionnelles ...
OPTIONS="--default-character-set=latin1 --set-charset"

# Chemin pour la sauvegarde + chemin à synchroniser avec la sauvegarde
BACKUP_DIR="/home/yannic/backup/db"
#RSYNC_DIR="/save/base"

# Nombre de backup a conserver
NB_ZIP=10

# Nom du fichier pour la restauration
RESTORESCRIPT="$BACKUP_DIR/__restoreData.sql"

# on recupère la date et l'heure pour le nom de la sauvegarde
DATE=`/bin/date '+%y-%m-%d_%Hh%M'`

#### début du script ####
echo 'Suppression des fichiers temporaires (*.sql) ...'
rm -f ${BACKUP_DIR}/*.sql > /dev/null 2>&1

cd ${BACKUP_DIR}

for DB in $DBNAMES
do
    echo "=========================================="
    echo "                 " ${DB}
    echo "=========================================="
    echo 'USE $DB;' > $RESTORESCRIPT
    echo 'SET FOREIGN_KEY_CHECKS=0;' > $RESTORESCRIPT

# Création d'un fichier contenant la structure + un fichier de données pour chaque tables
    for TABLE in `mysql $PORT $HOST $USER $PASSWORD $DB -e "SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB' AND TABLE_TYPE NOT LIKE '%VIEW%'" | egrep -v 'TABLE_NAME' `; do
        TABLENAME=$(echo $TABLE|awk '{ printf "%s", $0 }')
        FILENAMESTRUCT="${TABLENAME}_structure.sql"
        FILENAMEDATA="${TABLENAME}_data.sql"
        echo Dumping $TABLENAME
        echo "SELECT '     $TABLENAME' AS 'TABLE';" >> $RESTORESCRIPT
        echo 'source' $FILENAMESTRUCT';' >> $RESTORESCRIPT
        echo 'source' $FILENAMEDATA';' >> $RESTORESCRIPT
        echo Create file $FILENAMESTRUCT
        mysqldump --no-data $OPTIONS $PORT $HOST $USER $PASSWORD $DB $TABLENAME > ${BACKUP_DIR}/${FILENAMESTRUCT}
        echo Create file $FILENAMEDATA
        mysqldump --no-create-info $OPTIONS $PORT $HOST $USER $PASSWORD $DB $TABLENAME > ${BACKUP_DIR}/${FILENAMEDATA}
    done

# Création d'un fichier pour la création de chaque vue
    VIEWLIST=`mysql $HOST $USER $PASSWORD $DB -e "SELECT GROUP_CONCAT(TABLE_NAME SEPARATOR ' ') AS VIEW_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB' AND TABLE_TYPE LIKE '%VIEW%'" | egrep -v 'VIEW_NAME' `;
    FILENAMEVIEW="_${DB}_view.sql"
    echo Dumping $VIEWLIST
    echo "SELECT '     $VIEWLIST' AS 'VIEW';" >> $RESTORESCRIPT
    echo 'source' $FILENAMEVIEW';' >> $RESTORESCRIPT
    echo Create file $FILENAMEVIEW
    mysqldump --no-data $OPTIONS $PORT $HOST $USER $PASSWORD $DB $VIEWLIST > ${BACKUP_DIR}/${FILENAMEVIEW}

# Création du fichier des triggers et des routines
    FILENAMETRIGGER="_${DB}_trigger_function.sql"
    echo Dumping Trigger and Function
    echo "SELECT '     TRIGGER and FUNCTION' AS 'TRIGGER';" >> $RESTORESCRIPT
    echo 'source' $FILENAMETRIGGER';' >> $RESTORESCRIPT
    echo Create file $FILENAMETRIGGER
    mysqldump --triggers --routines --no-create-info --no-data --no-create-db --skip-opt $OPTIONS $PORT $HOST $USER $PASSWORD $DB > ${BACKUP_DIR}/${FILENAMETRIGGER}

    echo 'SET FOREIGN_KEY_CHECKS=1;' >> $RESTORESCRIPT

#    echo making tar...
#    tar -cf ${DB}_${DATE}.tar *.sql  > /dev/null 2>&1

    echo Compressing to ${DB}_${DATE}.zip
#    gzip -9 ${DB}_${DATE}.tar > /dev/null 2>&1
    rm -f ${BACKUP_DIR}/${DB}_${DATE}.zip > /dev/null 2>&1
    zip -X ${DB}_${DATE}.zip *.sql > /dev/null 2>&1

    echo removing temporary files...
    rm -f ${BACKUP_DIR}/*.sql > /dev/null 2>&1
#    rm -f ${BACKUP_DIR}/*.tar > /dev/null 2>&1
    echo "   done with     " $DB
    echo
    echo Removing old zip
#    find ${BACKUP_DIR}/${DB}_*.zip -mtime +7 -exec rm {} \;
    ls -1tr ${BACKUP_DIR}/${DB}_*.zip | head -n -${NB_ZIP} | xargs -d '\n' rm -f
done
echo "=========================================="
echo "            done with all database!       "
echo "=========================================="


#echo ""
#echo "=========================================="
#echo "=              Sync Data                 ="
#echo "=========================================="
#
#rsync -a --delete ${BACKUP_DIR}/ ${RSYNC_DIR} &> /dev/null
