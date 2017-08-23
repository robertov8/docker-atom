# VERSION:        0.1
# DESCRIPTION:    Image to build Atom and create a .rpm file

# Base docker image
FROM nodesource/fedora22:latest

# Install dependencies
RUN dnf --assumeyes install \
     make \
     gcc \
     gcc-c++ \
     glibc-devel \
     git-core \
     libsecret-devel \
     rpmdevtools \
     libX11-devel \
     libxkbfile-devel

RUN npm install -g npm --prefix=/usr/lib/ --loglevel error
