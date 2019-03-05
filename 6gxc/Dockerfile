FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt -y upgrade
RUN apt -y install vim sudo locales \
  build-essential git python cpio unzip rsync bc wget curl mtd-utils lzop \
  libncurses5-dev \
  python3
  
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

# nodejs
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | sh
RUN sh -c ". $HOME/.profile \
  && nvm install node"

# rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
# https://mexus.github.io/rustup-components-history/ 
# https://github.com/rust-lang/rust/issues/57947
# https://github.com/rust-lang/rust/issues/57464
RUN sh -c ". $HOME/.profile \
  && rustup default nightly-2019-01-02 \
  && rustup target add arm-unknown-linux-gnueabihf \
  && rustup target add arm-unknown-linux-musleabihf"

RUN mkdir -p $HOME/local $HOME/build

# musl.cc
RUN wget -P $HOME/downloads https://musl.cc/arm-linux-musleabihf-cross.tgz
RUN tar xf $HOME/downloads/arm-linux-musleabihf-cross.tgz -C $HOME/local/

# buildroot
ARG BUILDROOT_VERSION="2018.11.3"
RUN wget -P $HOME/downloads https://buildroot.org/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2
RUN tar xf $HOME/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2 -C $HOME/build/

# python
ARG PYTHON="3.6.7"
RUN wget -P $HOME/downloads https://www.python.org/ftp/python/$PYTHON/Python-$PYTHON.tgz
RUN tar xf $HOME/downloads/Python-$PYTHON.tgz -C $HOME/build/

# zlg
ADD packages /opt/zlg
RUN sudo tar xf /opt/zlg/qt-m6g2c.tar.bz2 -C /opt
RUN sudo tar xf /opt/zlg/tslib.tar.bz2 -C /opt
RUN tar xf /opt/zlg/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux.tar.bz2 -C $HOME/local/
# RUN tar xf /opt/zlg/uboot-src-d09434a.tar.gz -C $HOME/build
# RUN git clone http://git.denx.de/u-boot.git $HOME/build/uboot
# RUN cd $HOME/build/uboot && git checkout d09434a
RUN tar xf /opt/zlg/linux-src-5ee9e45.tar.gz -C $HOME/build

RUN sh -c ". /opt/zlg/env \
  && cd $HOME/build/Python-$PYTHON \
  && ./configure CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ AR=arm-linux-gnueabihf-ar RANLIB=arm-linux-gnueabihf-ranlib --host=arm-linux-gnueabihf --build=arm --disable-ipv6 ac_cv_file__dev_ptmx=no ac_cv_file__dev_ptc=no --prefix=/opt/python \
  && make install"

VOLUME /workspace
WORKDIR /workspace

CMD ["/bin/bash", "-l"]
