# https://wiki.debian.org/CrossCompiling
# https://wiki.debian.org/CrossToolchains
# https://wiki.debian.org/Multiarch/HOWTO

FROM debian:stretch

RUN echo '2019-02-01' >> /version

ENV DEBIAN_FRONTEND noninteractive

# packages
RUN dpkg --add-architecture armhf
RUN apt-get update
RUN apt-get -y install apt-utils
RUN apt-get -y upgrade
RUN apt-get -y install curl wget pwgen git vim tzdata sudo \
  build-essential dh-autoreconf locales pkg-config \
  gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf binutils-multiarch crossbuild-essential-armhf \
  libsodium-dev libsqlite3-dev libudev-dev libssl-dev libzmq3-dev liboping-dev \
  libsodium-dev:armhf libsqlite3-dev:armhf libudev-dev:armhf libssl-dev:armhf libzmq3-dev:armhf liboping-dev:armhf
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
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | sh
RUN sh -c ". $HOME/.profile \
  && nvm install node"

# rust https://mexus.github.io/rustup-components-history/ 
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
# https://github.com/rust-lang/rust/issues/57947
RUN sh -c ". $HOME/.profile \
  && rustup default nightly-2019-01-26 \
  && rustup target add armv7-unknown-linux-gnueabihf"

VOLUME /workspace
WORKDIR /workspace

CMD ["/bin/bash", "-l"]
