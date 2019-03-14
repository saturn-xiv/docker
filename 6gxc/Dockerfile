FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt -y upgrade
RUN apt -y install vim sudo locales \
  build-essential git python cpio unzip rsync bc wget curl mtd-utils lzop \
  libncurses5-dev  
RUN dpkg --add-architecture i386
RUN apt update
RUN apt -y install libc6:i386 libstdc++6:i386 zlib1g:i386

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
# https://forge.rust-lang.org/platform-support.html
# https://mexus.github.io/rustup-components-history/ 
# https://github.com/rust-lang/rust/issues/57947
# https://github.com/rust-lang/rust/issues/57464
RUN sh -c ". $HOME/.profile \
  && rustup default nightly-2019-01-02 \
  && rustup target add arm-unknown-linux-gnueabihf"
    
RUN mkdir -p $HOME/local $HOME/build

# zlg
ADD packages /opt/zlg
RUN sudo tar xf /opt/zlg/qt-m6g2c.tar.bz2 -C /opt
RUN sudo tar xf /opt/zlg/tslib.tar.bz2 -C /opt
RUN tar xf /opt/zlg/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux.tar.bz2 -C $HOME/local/
RUN tar xf /opt/zlg/linux-src-5ee9e45.tar.gz -C $HOME/build

# buildroot
ARG BUILDROOT_VERSION="2019.02"
RUN wget -P $HOME/downloads https://buildroot.org/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2
RUN tar xf $HOME/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2 -C $HOME/build/
RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION \
  && make raspberrypi3_64_defconfig \
  && make source
RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION \
  && make orangepi_zero_defconfig \
  && make source
RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION \
  && make orangepi_one_defconfig \
  && make source
COPY .config /home/deploy/build/buildroot-$BUILDROOT_VERSION/
RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION && make source
# RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION && make -j1 V=s

# third dependices must after buildroot build
RUN sudo apt -y install dh-autoreconf pkg-config \
  libpq-dev libsqlite3-dev libsodium-dev libudev-dev libssl-dev libzmq3-dev liboping-dev zlib1g-dev
RUN sudo apt -y autoremove
RUN sudo apt -y clean

COPY env /home/deploy/local/

VOLUME /workspace
WORKDIR /workspace

CMD ["/bin/bash", "-l"]
