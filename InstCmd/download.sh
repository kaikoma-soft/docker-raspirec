#!/bin/sh


down() {
    NAME=$1
    URL=$2
    if [ ! -s $NAME ]
    then
        wget -O $NAME $URL
    fi

    if [ ! -s $NAME ]
    then
        echo "Error: download 失敗"
        exit 
    fi
}


down raspirec-master.zip  https://github.com/kaikoma-soft/raspirec/archive/master.zip
down tspacketchk-main.zip https://github.com/kaikoma-soft/tspacketchk/archive/refs/heads/main.zip

down epgdump-master.zip   https://github.com/Piro77/epgdump/archive/master.zip
down libarib25-master.zip https://github.com/stz2012/libarib25/archive/master.zip
down recpt1-master.zip    https://github.com/stz2012/recpt1/archive/master.zip

# オリジナル
#down recdvb-1.3.2.tgz     http://www13.plala.or.jp/sat/recdvb/recdvb-1.3.2.tgz

# recpt1 互換
#down  recdvb-master.zip   https://github.com/dogeel/recdvb/archive/master.zip
down  recdvb-master.zip   https://github.com/kaikoma-soft/recdvb/archive/refs/heads/master.zip

if [ "$SC" = "yes" ]
then
    down LZVsh4x8         https://pastebin.com/raw/LZVsh4x8
fi
    
