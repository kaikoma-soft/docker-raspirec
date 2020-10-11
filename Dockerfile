# our base image
# raspbian の時は raspbian/stretch:latest に変更
FROM ubuntu:20.10

ARG DDIR_D
ARG HLS
ARG MPV
ARG SC
ARG RASPIRECDIR
ARG USERNAME

# 環境変数
ENV RASPIRECDIR=${RASPIRECDIR} \
    HLS=${HLS} \
    DDIR_D=${DDIR_D} \
    TMP_DIR=/tmp/raspirec \
    RUBYOPT=-EUTF-8 \
    LANG=ja_JP.UTF-8 \
    TZ="Asia/Tokyo" \
    USERNAME=$USERNAME


# for tzdata
ENV DEBIAN_FRONTEND=noninteractive

COPY InstCmd/*                  ${TMP_DIR}/
COPY Download/*                 ${TMP_DIR}/

RUN set -x \
    && sh ${TMP_DIR}/repoChg.sh \
    && sh ${TMP_DIR}/pkg_install.sh \
    && sh ${TMP_DIR}/libarib25.sh \
    && sh ${TMP_DIR}/recpt1.sh \
    && sh ${TMP_DIR}/recdvb.sh \
    && sh ${TMP_DIR}/epgdump.sh \
    && sh ${TMP_DIR}/raspirec.sh \
    && sh ${TMP_DIR}/pkg_remove.sh 

# tell the port number the container should expose
EXPOSE 5000

COPY InstCmd/start.sh           ${RASPIRECDIR}/

# run the application
CMD /bin/sh ${RASPIRECDIR}/start.sh
