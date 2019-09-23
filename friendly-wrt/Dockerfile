FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt -y upgrade
RUN apt -y install vim sudo locales \
  git wget python \
  bc
  # build-essential git python cpio unzip rsync bc wget curl mtd-utils lzop \
  # libncurses5-dev  

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=en_US.UTF-8
RUN update-alternatives --set editor /usr/bin/vim.basic

# deploy
RUN useradd -m deploy -s /bin/bash
RUN passwd -l deploy
RUN echo 'deploy ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/101-deploy
USER deploy

RUN wget -O - https://raw.githubusercontent.com/friendlyarm/build-env-on-ubuntu-bionic/master/install.sh | bash
RUN mkdir $HOME/bin

RUN git config --global user.email "deploy@local"
RUN git config --global user.name "Deploy"
RUN git clone https://github.com/friendlyarm/repo $HOME/friendlyarm/repo
RUN cp $HOME/friendlyarm/repo/repo $HOME/bin/
RUN sh -c ". $HOME/.profile \
  && mkdir $HOME/friendlyarm/manifests \
  && cd $HOME/friendlyarm/manifests \
  && yes "" | repo init -u https://github.com/friendlyarm/friendlywrt_manifests -b master -m h3.xml --repo-url=https://github.com/friendlyarm/repo --no-clone-bundle \
  && repo sync -c --no-clone-bundle"
RUN sh -c ". $HOME/.profile \
  && cd $HOME/friendlyarm/manifests \
  && ./build.sh nanopi_duo2.mk"

# # nodejs
# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | sh
# RUN sh -c ". $HOME/.profile \
#   && nvm install node"

# # rust
# RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
# RUN sh -c ". $HOME/.profile \
#   && rustup default nightly \
#   && rustup target add arm-unknown-linux-gnueabihf"
    
# RUN mkdir -p $HOME/local $HOME/build

# # buildroot
# ARG BUILDROOT_VERSION="2019.08"
# RUN wget -P $HOME/downloads https://buildroot.org/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2
# RUN tar xf $HOME/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2 -C $HOME/build/
# RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION \  
#   && make raspberrypi3_64_defconfig \
#   && make source
# RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION \  
#   && make orangepi_zero_defconfig \
#   && make source
# RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION \  
#   && make orangepi_one_defconfig \
#   && make source
# RUN cd $HOME/build/buildroot-$BUILDROOT_VERSION \  
#   && make friendlyarm_nanopi_neo2_defconfig \
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

VOLUME /workspace $HOME/friendlyarm/manifests/out
WORKDIR /workspace $HOME/friendlyarm/manifests/out

CMD ["/bin/bash", "-l"]
