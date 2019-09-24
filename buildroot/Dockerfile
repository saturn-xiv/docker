FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt -y upgrade
RUN apt -y install vim sudo locales \
  cmake build-essential git cpio unzip rsync bc wget curl mtd-utils lzop python libncurses5-dev libz-dev \
  dosfstools subversion parted gawk bison flex pkg-config dh-autoreconf
  
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
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | sh
RUN sh -c ". $HOME/.profile \
  && nvm install node"

# rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN sh -c ". $HOME/.profile \
  && rustup default nightly \
  && rustup target add arm-unknown-linux-gnueabihf"
    
RUN mkdir -p $HOME/local $HOME/build

# buildroot
ARG BUILDROOT_VERSION="2019.08"
RUN wget -P $HOME/downloads https://buildroot.org/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2
RUN tar xf $HOME/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2 -C $HOME/build/
RUN echo "export BUILDROOT=\$HOME/build/buildroot-$BUILDROOT_VERSION" >> $HOME/.profile
RUN mkdir $HOME/build/rpi3 \
  && cd $HOME/build/rpi3 \
  && make -C $HOME/build/buildroot-$BUILDROOT_VERSION O=$(pwd) raspberrypi3_64_defconfig \
  && make source
RUN mkdir $HOME/build/opi0 \
  && cd $HOME/build/opi0 \
  && make -C $HOME/build/buildroot-$BUILDROOT_VERSION O=$(pwd) orangepi_zero_defconfig \
  && make source
RUN mkdir $HOME/build/opi1 \
  && cd $HOME/build/opi1 \
  && make -C $HOME/build/buildroot-$BUILDROOT_VERSION O=$(pwd) orangepi_one_defconfig \
  && make source

VOLUME /workspace
WORKDIR /workspace

CMD ["/bin/bash", "-l"]
