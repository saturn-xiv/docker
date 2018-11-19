FROM alpine:latest

RUN echo '2018-11-16' >> /version

RUN apk update
RUN apk upgrade
RUN apk add vim zsh curl wget git pwgen sudo tzdata \
  cmake clang gcc g++ make libc6-compat \
  linux-headers zlib-dev bzip2-dev xz-dev icu-dev \
  libsodium-dev curl-dev sqlite-dev rabbitmq-c-dev hiredis-dev postgresql-dev
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime

# boost
# ENV BOOST_VERSION 1_68_0
# RUN mkdir $HOME/downloads
# RUN wget -P $HOME/downloads https://dl.bintray.com/boostorg/release/1.68.0/source/boost_1_68_0.tar.bz2
# RUN mkdir -p $HOME/build
# RUN tar xf $HOME/downloads/boost_$BOOST_VERSION.tar.bz2 -C $HOME/build
# RUN cd $HOME/build/boost_$BOOST_VERSION \
#   && ./bootstrap.sh \
#   && ./b2 install

# deploy
RUN adduser -D -s /bin/zsh deploy
RUN echo 'deploy ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/101-deploy
USER deploy

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

VOLUME /workspace
WORKDIR /workspace

CMD ["/bin/zsh"]
