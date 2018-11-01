FROM alpine:edge

RUN echo '2018-10-25' >> /version

RUN apk update
RUN apk upgrade
RUN apk add vim zsh curl wget git pwgen sudo tzdata \
  python3-dev py3-setuptools py3-cffi libffi-dev \
  perl \
  cmake clang gcc g++ make libc6-compat \
  boost-dev boost-static libsodium-dev curl-dev sqlite-dev sqlite-static rabbitmq-c-dev hiredis-dev postgresql-dev \
  nodejs npm nginx postgresql redis supervisor openssh-server
RUN pip3 install --upgrade pip
RUN pip install fabric

# deploy
RUN adduser -D -s /bin/zsh deploy
RUN echo "deploy:hi" | chpasswd
RUN echo 'deploy ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/101-deploy
USER deploy

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

# setup
USER root

RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime

RUN mkdir /var/run/sshd

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 3000/tcp 8080/tcp 22/tcp 5432/tcp 6379/tcp 9200/tcp 5672/tcp 15672/tcp 10000-11000/tcp

VOLUME /workspace /home/deploy/.ssh

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
