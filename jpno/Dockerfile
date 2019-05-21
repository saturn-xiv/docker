FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt -y upgrade
RUN apt -y install apt-utils apt-transport-https wget gnupg software-properties-common \ 
  curl build-essential cmake pkg-config dh-autoreconf dh-make checkinstall \
  cpio meson intltool libtool gawk texinfo bison bc zsh moreutils tree tzdata \
  libncurses5-dev \  
  net-tools lsof iputils-ping dnsutils psmisc inotify-tools logrotate locales \  
  zip unzip bsdtar telnet git vim pwgen sudo gperf \
  libssl-dev libreadline-dev zlib1g-dev \
  python3-pip libaio1

RUN apt -y autoremove
RUN apt -y clean

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=en_US.UTF-8
RUN update-alternatives --set editor /usr/bin/vim.basic

# oracle
ARG ORACLE_VERSION="19.3.0.0.0dbru"
ADD tmp/instantclient-basic-linux.x64-$ORACLE_VERSION.zip /
RUN unzip /instantclient-basic-linux.x64-$ORACLE_VERSION.zip -d /opt
RUN echo /opt/instantclient_19_3 > /etc/ld.so.conf.d/oracle.conf

# deploy
RUN useradd -s /bin/zsh -m deploy
RUN passwd -l deploy
RUN echo 'deploy ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/101-deploy
USER deploy

# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

# java sdk
RUN curl -s "https://get.sdkman.io" | zsh
RUN sed -i -e 's/sdkman_auto_answer=false/sdkman_auto_answer=true/g' $HOME/.sdkman/etc/config
RUN zsh -c "source $HOME/.zshrc \  
  && sdk install java \  
  && sdk install gradle"

# nodejs
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | zsh
RUN zsh -c "source $HOME/.zshrc \
  && nvm install node \
  && npm install -g yarn"

# python
RUN pip3 install --user pip
RUN echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.zshrc
RUN zsh -c "source $HOME/.zshrc \
  && pip install --user alembic cx_Oracle "

VOLUME /workspace
WORKDIR /workspace
