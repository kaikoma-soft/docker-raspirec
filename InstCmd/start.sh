#!/bin/sh
#
#  raspirec の起動
#
TMP="/tmp/tmp.$$"

ps -ax > $TMP
if grep pcscd $TMP > /dev/null
then
    echo "pcscd is run"
else
    /usr/sbin/service pcscd start
fi

sudo -u $USERNAME env RASPIREC_CONF=${DDIR_D}/config.rb ruby $RASPIRECDIR/raspirec.rb -f $*

rm -f $TMP


