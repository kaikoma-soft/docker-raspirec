#!/bin/sh

if [ "X$DEBUG" = "Xyes" ]
then
    set -x
fi

if [ "$USE_YAKISOBA" = "yes" ]
then
    echo
    echo "##### install libyakisoba #####"
    echo 
    
    WORKDIR="${TMP_DIR:=/tmp}/libyakisoba"
    
    mkdir -p $WORKDIR
    if test -d $WORKDIR
    then
        ( cd $WORKDIR
          SRC="${SRC:=$TMP_DIR/Download/libyakisoba.zip}"
          unzip -e $SRC
          if cd libyakisoba-*
          then
              autoreconf -i
              test -d build || mkdir build
              cd build
              ../configure --sysconfdir=${BCAS_DIR}
              make
              make install
          fi
        )
    fi
    
    WORKDIR="${TMP_DIR:=/tmp}/libsobacas"
    mkdir -p $WORKDIR
    if test -d $WORKDIR
    then
        ( cd $WORKDIR
          SRC="${SRC:=$TMP_DIR/Download/libsobacas.zip}"
          unzip -e $SRC
          if cd libsobacas-*
          then
              autoreconf -i
              test -d build || mkdir build
              cd build
              ../configure
              make
              make install
              install -m 644 -v -D -t /usr/local/include/libsobacas ../PCSC/*.h
          fi
        )
    fi

    PKGCONF_DIR="/usr/local/lib/pkgconfig"
    install -m 644 -v -D -t $PKGCONF_DIR $TMP_DIR/InstCmd/patch/libyakisoba.pc $TMP_DIR/InstCmd/patch/libsobacas.pc 
    
    ldconfig
fi

