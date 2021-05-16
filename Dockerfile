FROM ubuntu

ENV USER=jcuser
ENV PASSWORD=password
ENV HOME=/home/${USER}
ENV LANG=ja_JP.UTF-8

USER root

# update packages
RUN set -x && \
        apt update && \
        apt upgrade -y

# install system package
RUN set -x && \
        apt install -y sudo tzdata

# install nodejs
RUN set -x && \
        apt install -y nodejs npm

# install http-server
RUN set -x && \
        npm install -g http-server

# user
RUN set -x && \
	useradd -s /bin/bash -m ${USER} && \
	gpasswd -a ${USER} sudo && \
        echo "${USER}:${PASSWORD}" | chpasswd

USER ${USER}
WORKDIR ${HOME}

# install jscoq
RUN set -x && \
        npm install jscoq

# exec http server
WORKDIR ${HOME}/node_modules/jscoq
CMD http-server
