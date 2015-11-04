#!/usr/bin/env bash
#
#   A one directional auto-sync triggered by inotify.
#   The inotify-utils must be installed in the system
#   before using this script.
#

usage () {
    echo "Usage: `basename $0` source dest"
    echo "  source: local directory"
    echo "  dest: rsync target (local or remote directory)"
    echo 
    echo "Examples:"
    echo "> `basename $0` target/classes /app/testing/classes/."
    echo "> `basename $0` target/classes \"-e ssh root@server:/app/server/classes/.\""
    echo
    exit 0
}

if [ "$#" -lt 2 ]; then
    usage
fi

SOURCE=$1
DEST=$2

EVENTS="CREATE,DELETE,MODIFY,MOVED_FROM,MOVED_TO"

# Check if inotofywait is installed.
hash inotifywait 2>/dev/null
if [ $? -eq 1 ]; then
  echo "Unable to execute the script. Please make sure that inotify-utils
  is installed in the system."
  exit 1
fi

# Merge everything on startup 
rsync --update -alvzr $SOURCE/* $DEST

# Merge on change
inotifywait -e "$EVENTS" -m -r --format '%:e %f' $SOURCE | (
WAITING="";
while true; do
  LINE="";
  read -t 1 LINE;
  if test -z "$LINE"; then
    if test ! -z "$WAITING"; then
      echo "====================== CHANGE:  `date` ==========================";
      WAITING="";
      # Merge the changes before running rsync.
      rsync --update -alzrv $SOURCE/* $DEST
    fi;
  else
    WAITING=1;
  fi;
done)
