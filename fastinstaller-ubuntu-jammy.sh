#!/bin/bash

#
# (c) Mario Loderer, OpenSource-IT
# mario.loderer@osit.cc
#



# Apt Proxy bearbeiten oder einkommentieren
# echo 'Acquire::http { Proxy "http://apt-cacher.osit.cc:3142"; };' | tee /etc/apt/apt.conf.d/01proxy

gpg -k && gpg --no-default-keyring --keyring /usr/share/keyrings/iteas-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2FAB19E7CCB7F415
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/iteas-keyring.gpg] https://apt.iteas.at/iteas jammy main" > /etc/apt/sources.list.d/iteas.list
apt update
apt dist-upgrade -y
apt install ca-certificates-iteas-enterprise -y

cd /tmp

# Google Chrome oder Brave, wähle:

# Google Chrome:
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# apt install ./google-chrome-stable_current_amd64.deb

# Brave Secure Browser (Installation nur ohne Apt-Proxy möglich)
apt install curl -y
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"| tee /etc/apt/sources.list.d/brave-browser-release.list
apt update
apt install brave-browser -y


ubuntu-drivers autoinstall
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
apt install ./teamviewer_amd64.deb  -y

# extra manual package install because new compressionformat
# https://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg1852790.html
wget https://github.com/TheGoddessInari/hamsket/releases/download/0.6.3/hamsket_0.6.3_amd64.deb
wget https://files.strawberrymusicplayer.org/strawberry_1.0.4-impish_amd64.deb
apt install ./strawberry_1.0.4-impish_amd64.deb ./hamsket_0.6.3_amd64.deb -y

# Standard packages
apt install master-pdf-editor-5 ubuntu-restricted-extras vlc soundconverter htop hamsket draw.io keepassxc cifs-utils nfs-common samba aspell-de hunspell-de-at filezilla speedtest-cli gnome-nettool lm-sensors smartmontools flowblade simplescreenrecorder -y

apt remove rhythmbox apport -y
snap remove firefox
apt autoremove --purge -y
# rm /etc/apt/apt.conf.d/01proxy


# ------------------------------------------------------
# Ab hier bitte Dinge einkommentieren die du benötigst:
# ------------------------------------------------------

# Office Alternative, kompatibel zum Microsoftformat
apt install onlyoffice-desktopeditors -y

# Extra packages
pt install librecad synaptic mpv tree git audacity gparted -y

# Profi Fotoverwaltung
# apt install digikam kipi-plugins -y

# Profi Fotobearbeitung
# apt install gimp gimp-help-de -y

# Verwalten von Sammlungen inkl. Reportin
# apt install tellico -y


