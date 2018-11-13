# https://wiki.debian.org/CrossCompiling
# https://wiki.debian.org/Multiarch/HOWTO

FROM debian:stretch

RUN echo '2018-11-12' >> /version

ENV DEBIAN_FRONTEND noninteractive

# packages
RUN dpkg --add-architecture armhf
RUN apt-get update
RUN apt-get -y install apt-utils
RUN apt-get -y upgrade
RUN apt-get -y install curl wget pwgen git vim tzdata sudo \
  build-essential dh-autoreconf locales pkg-config \
  python python-pip \
  gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf binutils-multiarch \
  libsodium-dev:armhf libsqlite3-dev:armhf libudev-dev:armhf libssl-dev:armhf libzmq3-dev:armhf liboping-dev:armhf
RUN apt-get -y autoremove
RUN apt-get -y clean

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=en_US.UTF-8
RUN update-alternatives --set editor /usr/bin/vim.basic

RUN pip install --upgrade pip
RUN pip install ansible

# deploy
RUN useradd -m deploy
RUN passwd -l deploy
RUN echo 'deploy ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/101-deploy
USER deploy

# nodejs
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | sh
RUN bash -lc "nvm install node"

# rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN bash -lc "rustup override set nightly"
RUN bash -lc "rustup target add armv7-unknown-linux-gnueabihf"

VOLUME /workspace /home/deploy/.ssh
WORKDIR /workspace

CMD ["/bin/sh", "-l"]
