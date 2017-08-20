#!/bin/bash

# Download atom
if [ -d "atom" ]; then
    cd atom
    git pull
    cd ..
else
    git clone https://github.com/atom/atom.git
fi

# Remove old install
rm -rf atom/out/atom-*/

# Docker - Install Atom
docker build -t robertov82008/docker-atom .
docker run --rm --name docker-atom -v $PWD/atom:/atom -ti robertov82008/docker-atom script/build

# Create link atom-amd64
FILE_ATOM=$(find atom/out -name atom)
ln -s -f $FILE_ATOM atom-amd64
