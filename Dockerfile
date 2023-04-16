# 
# docker-raspirec Ver1.3.0
#
#  ・image は rolling
#    ( https://hub.docker.com/_/ubuntu/?tab=description  )
#
#  ・raspbian の時は raspbian/stretch:latest に変更
#  
FROM ubuntu:rolling

ARG DDIR_D
ARG HLS
ARG MPV
ARG SC
ARG RASPIRECDIR
ARG USERNAME
ARG DEBUG
ARG ARIBLIB
ARG USE_YAKISOBA
ARG BCAS_DIR

# 環境変数
ENV RASPIRECDIR=${RASPIRECDIR} \
    HLS=${HLS} \
    DDIR_D=${DDIR_D} \
    TMP_DIR=/tmp/raspirec \
    RUBYOPT=-EUTF-8 \
    LANG=ja_JP.UTF-8 \
    TZ="Asia/Tokyo" \
    USERNAME=$USERNAME \
    DEBUG=$DEBUG \
    ARIBLIB=$ARIBLIB \
    USE_YAKISOBA=$USE_YAKISOBA \
    BCAS_DIR=$BCAS_DIR


# for tzdata
ENV DEBIAN_FRONTEND=noninteractive

#COPY InstCmd                  ${TMP_DIR}/
#COPY Download                 ${TMP_DIR}/
COPY 2docker.tar         ${TMP_DIR}/

STOPSIGNAL SIGKILL

RUN set -x \
    && tar -C ${TMP_DIR} -xvof ${TMP_DIR}/2docker.tar \
    && sh ${TMP_DIR}/InstCmd/all.sh

# tell the port number the container should expose
EXPOSE 5000

COPY InstCmd/start.sh           ${RASPIRECDIR}/

# run the application
CMD /bin/sh ${RASPIRECDIR}/start.sh
