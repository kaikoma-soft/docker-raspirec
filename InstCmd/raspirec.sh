#!/bin/sh
set -x

echo
echo "##### install raspirec #####"
echo 

INSTDIR="${RASPIRECDIR:=/usr/local/raspirec}"
#NAME="raspirec-master"

test -d $INSTDIR || mkdir -p $INSTDIR
if cd $INSTDIR
then
    # SRC="${SRC_DIR}/Download/$NAME.zip"
    # unzip  $SRC
    # mv ${NAME}/* .
    # rm -f ${NAME}/.gitignore
    # rmdir --ignore-fail-on-non-empty ${NAME}

    if [ -d .git ]
    then
        git pull
    else
        git clone --depth=1 https://github.com/kaikoma-soft/raspirec.git .
    fi
fi

