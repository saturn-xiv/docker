FROM ubuntu:bionic

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

# RUN git clone https://github.com/friendlyarm/friendlywrt $HOME/friendlywrt
# RUN sh -c ". $HOME/.profile \
#   && cd $HOME/friendlywrt \
#   && ./scripts/feeds update -a \
#   && ./scripts/feeds install -a"

# RUN mknod /dev/loop0 b 7 0
# RUN sh -c ". $HOME/.profile \
#   && cd $HOME/friendlyarm/manifests \
#   && ./build.sh nanopi_duo2.mk"

VOLUME /workspace
WORKDIR /workspace

CMD ["/bin/bash", "-l"]
