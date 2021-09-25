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

# raspirec
down raspirec-master.zip  https://github.com/kaikoma-soft/raspirec/archive/master.zip

# tspacketchk
down tspacketchk-main.zip https://github.com/kaikoma-soft/tspacketchk/archive/refs/heads/main.zip

# epgdump オリジナル
#down epgdump-master.zip   https://github.com/Piro77/epgdump/archive/master.zip

# epgdump 改造版
down epgdump-master.zip   https://github.com/kaikoma-soft/epgdump/archive/refs/heads/master.zip

# libarib25
down libarib25-master.zip https://github.com/stz2012/libarib25/archive/master.zip

# recpt1 オリジナル
#down recpt1-master.zip    https://github.com/stz2012/recpt1/archive/master.zip

# recpt1 改造版
down recpt1-master.zip    https://github.com/kaikoma-soft/recpt1/archive/refs/heads/master.zip

# recdvb オリジナル
#down recdvb-1.3.2.tgz     http://www13.plala.or.jp/sat/recdvb/recdvb-1.3.2.tgz

# recdvb 互換
#down  recdvb-master.zip   https://github.com/dogeel/recdvb/archive/master.zip

# recdvb 改造版
down  recdvb-master.zip   https://github.com/kaikoma-soft/recdvb/archive/refs/heads/master.zip


    
