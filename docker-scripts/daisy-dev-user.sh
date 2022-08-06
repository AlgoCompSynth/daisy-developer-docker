#! /bin/bash

set -e

echo "Installing Linux dependencies"
apt-get update
apt-get upgrade -y
apt-get autoremove --purge -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  bash-completion \
  build-essential \
  bzip2 \
  ca-certificates \
  curl \
  file \
  git \
  git-lfs \
  gnupg2 \
  gzip \
  less \
  locales \
  lynx \
  mlocate \
  openssh-client \
  pkg-config \
  software-properties-common \
  sudo \
  tar \
  texinfo \
  time \
  tree \
  tzdata \
  unzip \
  vim-nox \
  wget \
  zip \
  zlib1g-dev

apt-get clean

echo "Creating 'daisy-dev' user"
useradd \
  --shell /bin/bash \
  --user-group \
  --groups adm,audio,cdrom,dip,plugdev,sudo,video \
  --create-home \
  --uid 1000 daisy-dev \
  && echo "daisy-dev:daisy-dev" | chpasswd

echo "Finished!"
