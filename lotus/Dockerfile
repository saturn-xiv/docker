FROM ubuntu:latest

RUN echo '2018-12-25' >> /version

ENV DEBIAN_FRONTEND noninteractive

# packages
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install apt-utils apt-transport-https wget gnupg software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections

RUN wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
RUN apt-key add rabbitmq-signing-key-public.asc
RUN echo "deb https://dl.bintray.com/rabbitmq/debian bionic main" > /etc/apt/sources.list.d/rabbitmq.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6B73A36E6026DFCA

RUN wget https://artifacts.elastic.co/GPG-KEY-elasticsearch
RUN apt-key add GPG-KEY-elasticsearch
RUN echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" > /etc/apt/sources.list.d/elasticsearch.list

RUN apt-get update
RUN apt-get -y install build-essential clang cmake pkg-config dh-autoreconf dh-make checkinstall \
  cpio meson intltool libtool gawk texinfo bison bc zsh moreutils tree tzdata \
  libncurses5-dev \
  ansible ansible-lint \
  net-tools lsof iputils-ping dnsutils psmisc inotify-tools logrotate \
  musl musl-dev musl-tools llvm \
  zip unzip bsdtar telnet curl git vim pwgen sudo gperf \
  libsodium-dev libpq-dev libmysqlclient-dev libsqlite3-dev libudev-dev liboping-dev libzmq3-dev \
  libssl-dev libreadline-dev zlib1g-dev oracle-java8-installer \
  sqlite3 postgresql mariadb-server redis rabbitmq-server openssh-server nginx supervisor
RUN apt-get -y install elasticsearch
RUN apt-get -y autoremove
RUN apt-get -y clean

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=en_US.UTF-8
RUN update-alternatives --set editor /usr/bin/vim.basic

RUN /usr/sbin/rabbitmq-plugins enable rabbitmq_management
RUN chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
RUN chmod 600 /var/lib/rabbitmq/.erlang.cookie

RUN mkdir /var/run/sshd

RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld

RUN mkdir -p /var/run/postgresql/10-main.pg_stat_tmp
RUN chown -R postgres:postgres /var/run/postgresql
RUN echo "local   all             all                                     trust" > /etc/postgresql/10/main/pg_hba.conf
RUN echo "host    all             all             127.0.0.1/32            trust" >> /etc/postgresql/10/main/pg_hba.conf
RUN echo "host    all             all             ::1/128                 trust" >> /etc/postgresql/10/main/pg_hba.conf
RUN echo "log_statement = 'all'" >> /etc/postgresql/10/main/postgresql.conf

# deploy
RUN useradd -s /bin/zsh -m deploy
RUN passwd -l deploy
RUN echo 'deploy ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/101-deploy
RUN echo "deploy:hi" | chpasswd
RUN mkdir /opt/saturn-xiv
RUN chown deploy:deploy /opt/saturn-xiv
USER deploy

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true
RUN mkdir $HOME/downloads

ENV ANDROID_SDK_VERSION 4333796
RUN wget -P $HOME/downloads https://dl.google.com/android/repository/sdk-tools-linux-$ANDROID_SDK_VERSION.zip
RUN mkdir -pv $HOME/local/android-sdk
RUN unzip $HOME/downloads/sdk-tools-linux-$ANDROID_SDK_VERSION.zip -d $HOME/local/android-sdk
RUN yes | $HOME/local/android-sdk/tools/bin/sdkmanager --licenses

ENV BUILDROOT_VERSION="2018.08"
RUN mkdir -p $HOME/local/buildroot
RUN wget -P $HOME/downloads https://buildroot.org/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2
RUN tar xf $HOME/downloads/buildroot-$BUILDROOT_VERSION.tar.bz2 -C $HOME/local/buildroot

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | zsh
RUN zsh -c "source $HOME/.zshrc \
  && nvm install node \
  && npm install -g grunt-cli serve umi"

RUN curl -s "https://get.sdkman.io" | zsh
RUN sed -i -e 's/sdkman_auto_answer=false/sdkman_auto_answer=true/g' $HOME/.sdkman/etc/config
RUN zsh -c "source $HOME/.zshrc \
  && sdk install java 8.0.191-oracle \
  && sdk install maven \
  && sdk install gradle"

RUN git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
RUN git clone https://github.com/rbenv/rbenv-vars.git $HOME/.rbenv/plugins/rbenv-vars
RUN echo 'export PATH=$HOME/.rbenv/bin:$PATH' >> $HOME/.zshrc
RUN echo 'eval "$(rbenv init -)"' >> $HOME/.zshrc
RUN zsh -c "source $HOME/.zshrc \
  && rbenv install 2.5.1 \
  && rbenv global 2.5.1 \
  && gem install bundler \
  && gem install rubocop"

# rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN echo 'source $HOME/.cargo/env' >> $HOME/.zshrc
RUN zsh -c "source $HOME/.zshrc \
  && rustup default nightly \
  && rustup component add rls-preview rust-analysis rust-src rustfmt clippy"
# https://github.com/rust-lang/rust/issues/50504#issuecomment-410550021
RUN echo 'export RUSTFLAGS="-Aproc-macro-derive-resolution-fallback"' >> $HOME/.zshrc

# saturn-xiv
RUN zsh -c "source $HOME/.zshrc \
  && git clone https://github.com/saturn-xiv/lotus.git /opt/saturn-xiv/lotus"

# setup
USER root

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 3000/tcp 8080/tcp 22/tcp

VOLUME /workspace /home/deploy/.ssh

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
