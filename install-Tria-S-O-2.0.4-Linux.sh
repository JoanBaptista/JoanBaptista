#!/bin/bash

# Un cop descomprimit el arxiu install-Tria-Sistema-Operatiu-2.0.4-Linux.zip
# (amb TriaSO.gambas, unetbootin-linux-702.bin i unetbootin-linux64-702.bin)
# li donem permisos d'execució als 3 arxius i canviem el nom dels binaris
# unetbootin per permetre que Tria S.O. 2.0.4 obri el de 64 bits quan
# es faci servir cpu de 64 bits i si no, el unetbootin de 32 bits.

clear

echo 'You should run this script as root.'

DEBIANDISTRO=/etc/debian_version
REDHATDISTRO=/etc/redhat-release
SLACKWAREDISTRO=/etc/slackware-version
GENTOODISTRO=/etc/gentoo-release
ARCHDISTRO=/etc/arch-release
SUSEDISTRO=/etc/suse-release

chmod +x Tria*.gambas
chmod +x unetbootin-linux*
cp unetbootin-linux-702.bin unetbootin32
cp unetbootin-linux64-702.bin unetbootin

echo 'To be able to use unetboontin to burn a iso file to USB'
echo 'now you will have to allow the installer to copy unetbootin'
echo 'to the right path (/usr/bin/ requires sudo password).'

cp unetboot* /usr/bin

echo 'To be able to detect OpenGL version for this GPU (Graphic Processor Unit)'
echo 'you will need the mesa-utils package (includes ifgx command).'

# Distribucions base DEBIAN GNU/Linux, amb paquets .deb i
# gestor de paquets apt com Debian, Ubuntu, Linux Mint, Knoppix ... etc
if [ -f "$DEBIANDISTRO" ]; then
echo 'Debian base distro detected. Installing mesa-utils package using apt'
apt install mesa-utils
fi

# Distribucions base Red Hat, amb paquets .rpm i
# gestor de paquets rpm com Red Hat, CentOS, Mageia, Fedora ... etc
if [ -f "$REDHATDISTRO" ]; then
echo 'Red Hat base distro detected. Installing mesa-libGL package using yum'
yum install mesa-libGL
fi

# Distribucions base SLACKWARE, amb paquets .txz
if [ -f "$SLACKWAREDISTRO" ]; then
echo 'Slackware base distro detected. Installing mesa package using wget and upgradepkg'
wget https://slackware.uk/slackware/slackware64-14.2/slackware64/x/mesa-11.2.2-x86_64-1.txz
upgradepkg --install-new mesa-11.2.2-x86_64-1.txz
fi

# Distribucions base Gentoo, amb gestor de paquets COMPRIMITS
# .tar.gz ?
if [ -f "$GENTOODISTRO" ]; then
echo 'Gentoo base distro detected. Installing mesa-progs package using emerge'
emerge mesa-progs -av
fi

# Distribucions base ARCH, com ARCH o Manjaro, amb gestor 
# de paquets COMPRIMITS ... .tar.gz ?

if [ -f "$ARCHDISTRO" ]; then
echo 'Arch base distro detected. Installing mesa-demos package using pacman'
pacman -S mesa-demos
fi

# Distribucions base SUSE, amb paquets .rpm i 
# gestor de paquets zypper com SuSE, OpenSUSE, ... etc
if [ -f "$SUSEDISTRO" ]; then
echo 'SUSE base distro detected. Installing mesa-demo-x using zypper'
zypper install Mesa-demo-x
fi

echo 'Tria S.O. 2.0.4 for Linux already installed !'
echo 'Create a shorcut of the file Tria-S-O.gambas to your desktop'
echo 'if you want to run the program from your desktop.'
