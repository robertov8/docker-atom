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
sudo rm -rf atom/apm/node_modules
sudo rm -rf atom/out/atom-*/

# Docker - Install Atom
docker-compose run atom script/build --install

# Fix .desktop
echo 'Fix atom.desktop'

su root -c 'cat <<EOF > /usr/local/share/applications/atom.desktop
[Desktop Entry]
Name=Atom
Comment=A hackable text editor for the 21st Century.
GenericName=Text Editor
Exec=/usr/local/share/atom/atom %F
Icon=/usr/local/share/atom/atom.png
Type=Application
StartupNotify=true
Categories=GNOME;GTK;Utility;TextEditor;Development;
MimeType=text/plain;
EOF'