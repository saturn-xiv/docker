FROM ubuntu:xenial

RUN echo '2018-11-01' >> /version

ENV DEBIAN_FRONTEND noninteractive

# packages
RUN apt-get update
RUN apt-get -y install curl apt-utils apt-transport-https wget gnupg software-properties-common
# RUN dpkg --add-architecture armhf
# RUN echo "deb [arch=amd64,i386] http://uk.archive.ubuntu.com/ubuntu/ xenial main universe" > /etc/apt/sources.list
#
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install build-essential locales pkg-config dh-autoreconf \
  git vim nodejs python3-pip \
  gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf binutils-multiarch \
  libsqlite3-dev

RUN echo "deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports/ xenial main restricted multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports/ xenial-updates main restricted multiverse" >> /etc/apt/sources.list
RUN echo "deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports xenial main universe" >> /etc/apt/sources.list
RUN echo "deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports/ xenial-updates universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install libsodium-dev:armhf libsqlite3-dev:armhf libudev-dev:armhf libssl-dev:armhf libzmq3-dev:armhf
RUN apt-get -y autoremove
RUN apt-get -y clean
#
# RUN pip3 install fabric
#
# RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
# RUN locale-gen
# RUN update-locale LANG=en_US.UTF-8
# RUN update-alternatives --set editor /usr/bin/vim.basic
#
# # rust
# RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
# RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
# RUN /bin/bash -c "source $HOME/.cargo/env \
#   && rustup override set nightly \
#   && rustup target add armv7-unknown-linux-gnueabihf"
# # https://github.com/rust-lang/rust/issues/50504#issuecomment-410550021
# RUN echo 'export RUSTFLAGS="-Aproc-macro-derive-resolution-fallback"' >> $HOME/.bashrc
# RUN /bin/bash -c "source $HOME/.cargo/env \
#   && cargo install --force diesel_cli --no-default-features --features sqlite"
#
#
# # deploy
# RUN useradd -s /bin/zsh -m deploy
# RUN passwd -l deploy
# RUN echo 'deploy ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/101-deploy
# RUN echo "deploy:hi" | chpasswd

VOLUME /workspace
WORKDIR /workspace

CMD ["/bin/bash"]
