FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt -y upgrade
RUN apt -y install vim sudo locales \
  build-essential git python cpio unzip rsync bc wget curl mtd-utils lzop \
  libncurses5-dev  

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
ARG BUILDROOT_VERSION="2019.05.1"
RUN wget -P $HOME/downloads https://buildroot.org/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2
RUN tar xf $HOME/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2 -C $HOME/build/
# RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION \  
#   && make raspberrypi3_64_defconfig \
#   && make source
# RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION \  
#   && make orangepi_zero_defconfig \
#   && make source
# RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION \  
#   && make orangepi_one_defconfig \
#   && make source
# COPY .config /home/deploy/build/buildroot-$BUILDROOT_VERSION/
# RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION && make source
# RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION && make -j1 V=s

# third dependices must after buildroot build
# RUN sudo apt -y install dh-autoreconf pkg-config \
#   libpq-dev libsqlite3-dev libsodium-dev libudev-dev libssl-dev libzmq3-dev liboping-dev zlib1g-dev
# RUN sudo apt -y autoremove
# RUN sudo apt -y clean

# COPY env /home/deploy/local/

VOLUME /workspace $HOME/build/buildroot-$BUILDROOT_VERSION/output
WORKDIR /workspace

CMD ["/bin/bash", "-l"]
