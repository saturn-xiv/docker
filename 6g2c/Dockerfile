FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

ARG BUILDROOT_VERSION="2018.11.3"

RUN apt update
RUN apt -y upgrade
RUN apt -y install vim sudo locales \
  build-essential python cpio unzip rsync bc wget \
  libncurses5-dev git
RUN apt -y autoremove
RUN apt -y clean

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=en_US.UTF-8
RUN update-alternatives --set editor /usr/bin/vim.basic

# deploy
RUN useradd -m deploy -s /bin/bash
RUN passwd -l deploy
RUN echo 'deploy ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/101-deploy
USER deploy

RUN wget -P $HOME/downloads https://buildroot.org/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2
RUN tar xf $HOME/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2 -C $HOME/local/

VOLUME /workspace
WORKDIR /workspace

CMD ["/bin/bash", "-l"]
