FROM ich777/winehq-baseimage

LABEL org.opencontainers.image.authors="mainfrezzer@magnon.ovh"
LABEL org.opencontainers.image.source="https://github.com/Mainfrezzer/ase-docker"

RUN apt-get update && \
	apt-get -y install --no-install-recommends lib32gcc-s1 lib32stdc++6 lib32z1 xvfb winbind && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="376030"
ENV GAME_PARAMS="?Port=7777"
ENV GAME_PARAMS_EXTRA="-server -log -NoBattlEye"
ENV MAP="TheIsland"
ENV SERVER_NAME="ASE Docker"
ENV SRV_PWD="Docker"
ENV SRV_ADMIN_PWD="adminDocker"
ENV GAME_PORT=27015
ENV VALIDATE=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""
ENV USER="steam"
ENV DATA_PERM=770

RUN mkdir $DATA_DIR && \
	mkdir $STEAMCMD_DIR && \
	mkdir $SERVER_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 65536

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
