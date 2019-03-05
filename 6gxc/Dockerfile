FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt -y upgrade
RUN apt -y install vim sudo locales \
  build-essential python cpio unzip rsync bc wget \
  libncurses5-dev git \
  lzop
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

RUN mkdir -p $HOME/local

# rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
# https://mexus.github.io/rustup-components-history/ 
# https://github.com/rust-lang/rust/issues/57947
# https://github.com/rust-lang/rust/issues/57464
RUN sh -c ". $HOME/.profile \
  && rustup default nightly-2019-01-02 \
  && rustup target add arm-unknown-linux-gnueabihf \
  && rustup target add arm-unknown-linux-musleabihf"

# musl.cc
RUN wget -P $HOME/downloads https://musl.cc/arm-linux-musleabihf-cross.tgz
RUN tar xf $HOME/downloads/arm-linux-musleabihf-cross.tgz -C $HOME/local/

# buildroot
ARG BUILDROOT_VERSION="2018.11.3"
RUN wget -P $HOME/downloads https://buildroot.org/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2
RUN tar xf $HOME/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2 -C $HOME/local/

# zlg
ADD packages /opt/packages
RUN tar xf /opt/packages/qt-m6g2c.tar.bz2 -C /opt
RUN tar xf /opt/packages/tslib.tar.bz2 -C /opt
RUN tar xf /opt/packages/gcc-linaro-arm-linux-gnueabihf-4.9-2014.9_linux.tar.bz2 -C $HOME/local/
RUN mkdir  $HOME/build
RUN tar xf /opt/packages/uboot-src-d09434a.tar.gz -C $HOME/build
RUN tar xf /opt/packages/linux-src-a0722e0.tar.gz -C $HOME/build
ADD zlg $HOME/local/zlg

VOLUME /workspace
WORKDIR /workspace

CMD ["/bin/bash", "-l"]
