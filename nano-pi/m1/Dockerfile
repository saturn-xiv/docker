FROM ubuntu:xenial

RUN echo '2018-11-01' >> /version

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386
RUN dpkg --add-architecture armhf
# http://wiki.friendlyarm.com/wiki/index.php/NanoPi_M1#Make_Your_Own_Debian
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install wget vim zsh \
  gawk git gnupg flex bison gperf build-essential \
  zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev \
  libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 \
  libgl1-mesa-dev g++-multilib tofrodos \
  python-markdown libxml2-utils xsltproc zlib1g-dev:i386
RUN apt-get -y autoremove
RUN apt-get clean
RUN git clone https://github.com/friendlyarm/h3_lichee.git /opt/lichee
RUN wget -o /tmp/gcc-linaro-arm.tar.xz https://doc-14-ao-docs.googleusercontent.com/docs/securesc/q2iiuuobshr1fhvmnc3sr3d0n1oj25dp/pbtotte6hacl7csc1kjseotg3vmjlis7/1539432000000/16347812152386105528/12042498909132218732/1f_lty-fMHl_q6PzeC84gHFCrk389LUvB?e=download
