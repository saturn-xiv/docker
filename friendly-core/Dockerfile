FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive
ENV UBUNTU xenial
ENV HOSTNAME friendly-core

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install curl wget build-essential cmake locales pkg-config dh-autoreconf \
  git vim sudo tzdata pwgen \
  gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf binutils-multiarch \  
  libsodium-dev libsqlite3-dev libudev-dev libssl-dev libzmq3-dev liboping-dev libasound2-dev \
  libpq-dev libmysqlclient-dev \
  rsync openssh-client

RUN dpkg --add-architecture armhf
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ $UBUNTU main restricted" > /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ $UBUNTU-updates main restricted" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ $UBUNTU universe" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ $UBUNTU-updates universe" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ $UBUNTU multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ $UBUNTU-updates multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ $UBUNTU-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://security.ubuntu.com/ubuntu/ $UBUNTU-security main restricted" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://security.ubuntu.com/ubuntu/ $UBUNTU-security universe" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://security.ubuntu.com/ubuntu/ $UBUNTU-security multiverse" >> /etc/apt/sources.list

RUN echo "deb [arch=armhf] http://ports.ubuntu.com/ $UBUNTU main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=armhf] http://ports.ubuntu.com/ $UBUNTU-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=armhf] http://ports.ubuntu.com/ $UBUNTU-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=armhf] http://ports.ubuntu.com/ $UBUNTU-backports main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install python3-pip \
  libsodium-dev:armhf libsqlite3-dev:armhf libudev-dev:armhf libssl-dev:armhf libzmq3-dev:armhf liboping-dev:armhf libasound2-dev:armhf \  
  qt5-default:armhf qtmultimedia5-dev:armhf
RUN apt-get -y autoremove
RUN apt-get -y clean

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=en_US.UTF-8
RUN update-alternatives --set editor /usr/bin/vim.basic

# deploy
RUN useradd -m deploy -s /bin/bash
RUN passwd -l deploy
RUN echo 'deploy ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/101-deploy
USER deploy


# nodejs
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh | sh
RUN sh -c ". $HOME/.profile \
  && nvm install node"
RUN sh -c ". $HOME/.profile \
  && npm install -g yarn"

# https://mexus.github.io/rustup-components-history/ 
RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y
RUN sh -c ". $HOME/.profile \
  && rustup target add armv7-unknown-linux-gnueabihf"

# ansible
RUN sh -c "pip3 install --user ansible psycopg2 ipaddress"
RUN echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.profile

# axis
RUN sh -c ". $HOME/.profile \
  && cargo install --git https://github.com/saturn-xiv/axis.git"

VOLUME /workspace
WORKDIR /workspace

CMD ["/bin/bash", "-l"]
