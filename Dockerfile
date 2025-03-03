FROM ich777/debian-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-openmw-tes3mp"

COPY cjson.tar.gz /tmp/

# Top Priority:
# TODO: Figure out how to add ssh keys from a mapped dir?
# TODO: start script should start openssh-server service

# Medium priority:
# TODO: Other nice-to-have packages (whatever ifconfig is in, whatever ping is in)

RUN apt-get update && \
	apt-get -y install --no-install-recommends libluajit-5.1-2 \
	libgl1 \
	lua-cjson \
	jq \
	curl \
	openssh-server \
	net-tools \
	iputils-ping \
	nano \
	tmux \
	fish \
	atool \
	exa \
	fd-find \
	ripgrep \
	bat \
	delta \
	shellcheck \
	htop \
	&& \
	tar -C / -xvf /tmp/cjson.tar.gz && \
	rm -rf /tmp/cjson.tar.gz && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR=/openmw
ENV HOME_CONFIG_DIR=/homeconfig
ENV GAME_V="latest"
ENV SRV_NAME="Docker OpenMW"
ENV GAME_PARAMS=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV DATA_PERM=770
ENV USER="openmw"

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

RUN fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && \
	fisher install jorgebucaran/fisher"

RUN fish -c "fisher install \
	jorgebucaran/autopair.fish \
	gazorby/fish-abbreviation-tips \
	patrickf1/fzf.fish \
	jorgebucaran/getopts.fish \
	paldepind/projectdo \
	jethrokuan/z \
	ilancosman/tide@v6"

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
