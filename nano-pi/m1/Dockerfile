FROM ubuntu:xenial

RUN echo '2018-11-03' >> /version

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install curl wget build-essential locales pkg-config dh-autoreconf \
  git vim nodejs python3-pip \
  gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf binutils-multiarch \
  libsqlite3-dev

RUN dpkg --add-architecture armhf
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ xenial main restricted" > /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ xenial universe" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ xenial-updates universe" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ xenial-updates multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://security.ubuntu.com/ubuntu/ xenial-security main restricted" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://security.ubuntu.com/ubuntu/ xenial-security universe" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://security.ubuntu.com/ubuntu/ xenial-security multiverse" >> /etc/apt/sources.list

RUN echo "deb [arch=armhf] http://ports.ubuntu.com/ xenial main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=armhf] http://ports.ubuntu.com/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=armhf] http://ports.ubuntu.com/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=armhf] http://ports.ubuntu.com/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install libsodium-dev:armhf libsqlite3-dev:armhf libudev-dev:armhf libssl-dev:armhf libzmq3-dev:armhf
RUN apt-get -y autoremove
RUN apt-get -y clean

RUN pip3 install --upgrade pip
RUN pip3 install fabric

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=en_US.UTF-8
RUN update-alternatives --set editor /usr/bin/vim.basic

# deploy
RUN useradd -m deploy
RUN passwd -l deploy
USER deploy

# nodejs
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | sh
RUN bash -lc "nvm install node"

# rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN bash -lc "rustup override set nightly"
RUN bash -lc "rustup target add armv7-unknown-linux-gnueabihf"
RUN bash -lc "cargo install diesel_cli --no-default-features --features sqlite"

VOLUME /workspace /home/deploy/.ssh

CMD ["/bin/sh", "-l"]
