#!/bin/sh
#
#  raspirec の起動/停止
#

export RASPIREC_CONF=XXXX/config.rb
export RASPIRECDIR=YYYY

if [ "$1" = "start" ]
then
    ruby $RASPIRECDIR/raspirec.rb $*
elif [ "$1" = "stop" ]
then
    ruby $RASPIRECDIR/raspirec.rb --kill
else
    echo "使用法: $0 start|stop"
fi



