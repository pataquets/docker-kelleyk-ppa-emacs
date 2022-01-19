FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    ca-certificates \
    gnupg \
  && \
  apt-key adv --keyserver hkps://keyserver.ubuntu.com --recv-keys EAAFC9CD && \
    . /etc/lsb-release && \
  echo "deb http://ppa.launchpad.net/kelleyk/emacs/ubuntu ${DISTRIB_CODENAME} main" \
    | tee /etc/apt/sources.list.d/kelleyk-emacs.list \
  && \
  apt-get purge -y --autoremove \
    gnupg \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ARG EMACS_PACKAGE
RUN \
  apt-get update && \
  apt-get install -y \
    ${EMACS_PACKAGE:-emacs27} \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN emacs --version

ENTRYPOINT [ "emacs" ]
