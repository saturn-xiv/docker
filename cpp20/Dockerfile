FROM alpine:latest

RUN echo '2018-11-21' >> /version

RUN apk update
RUN apk upgrade
RUN apk add vim zsh curl wget git pwgen sudo tzdata \
  cmake clang gcc g++ make libc6-compat \
  linux-headers zlib-dev bzip2-dev xz-dev icu-dev \
  libsodium-dev curl-dev sqlite-dev rabbitmq-c-dev hiredis-dev postgresql-dev
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime

# deploy
RUN adduser -D -s /bin/zsh deploy
RUN echo 'deploy ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/101-deploy
USER deploy

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

VOLUME /workspace
WORKDIR /workspace

CMD ["/bin/zsh"]
