#!/bin/bash

# Download atom
if [ -d "atom" ]; then
    cd atom && git pull
else
    git clone https://github.com/atom/atom.git && cd atom
fi

# Choise version
# List last version
counter=1
for i in $( git tag --sort=creatordate | tail -n 10 ); do
	echo "${counter} - $i"
	let counter=counter+1
done

printf "\nChoise number your version: "
read CHOISE

VERSION=$( git tag --sort=creatordate | tail -n 10 | sed "$CHOISE q;d" )
git checkout -B $VERSION

cd ..

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