FROM ubuntu:20.04

ENV USER=jsuser
ENV PASSWORD=password
ENV HOME=/home/${USER}
ENV LANG=ja_JP.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

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
        chown -R ${USER}:${USER} /home/${USER} && \
	gpasswd -a ${USER} sudo && \
        echo "${USER}:${PASSWORD}" | chpasswd

USER ${USER}
WORKDIR ${HOME}

# install jscoq
RUN set -x && \
       npm install jscoq

RUN set -x && \
        cp node_modules/jscoq/examples/npm-template.html ./index.html

# exec http server
CMD http-server
