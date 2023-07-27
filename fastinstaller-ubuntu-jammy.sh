#!/bin/bash

#
# (c) Mario Loderer, OpenSource-IT
# mario.loderer@osit.cc
#



# Apt Proxy bearbeiten oder einkommentieren
# Edit or comment Apt Proxy
#echo 'Acquire::http { Proxy "http://apt-cacher.osit.cc:3142"; };' | tee /etc/apt/apt.conf.d/01proxy

gpg -k && gpg --no-default-keyring --keyring /usr/share/keyrings/iteas-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 23CAE45582EB0928
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/iteas-keyring.gpg] http://apt.iteas.at/iteas jammy main" > /etc/apt/sources.list.d/iteas.list
apt update
apt dist-upgrade -y
apt install ca-certificates-iteas-enterprise -y

cd /tmp

# Google Chrome oder Brave, wähle:
# Google Chrome or Brave, choose:

# Google Chrome:
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#apt install ./google-chrome-stable_current_amd64.deb

# Brave Secure Browser
apt install curl -y
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"| tee /etc/apt/sources.list.d/brave-browser-release.list
apt update
apt install brave-browser -y


ubuntu-drivers autoinstall

# Standard packages
apt install master-pdf-editor-5 ubuntu-restricted-extras vlc soundconverter htop draw.io bitwarden cifs-utils nfs-common samba aspell-de hunspell-de-at filezilla speedtest-cli gnome-nettool lm-sensors smartmontools flowblade simplescreenrecorder strawberry rustdesk -y

apt remove rhythmbox apport -y
apt autoremove --purge -y


# ------------------------------------------------------
# Ab hier bitte Dinge einkommentieren die du benötigst:
# From here please comment things you need:
# ------------------------------------------------------


# Office Alternative, kompatibel zum Microsoftformat
# Office alternative, compatible with Microsoft format
apt install onlyoffice-desktopeditors -y
apt remove libreoffice* --purge -y

# Extra packages
#apt install librecad synaptic mpv tree git audacity gparted -y

# Profi Fotoverwaltung
# Professional photo management
#apt install digikam kipi-plugins -y

# Profi Fotobearbeitung
# Professional photo editing
#apt install gimp gimp-help-de darktable -y

# Verwalten von Sammlungen inkl. Reportin
# Manage collections including reportin
#apt install tellico -y

# optional Multimediapackages
#apt-add-repository ppa:heyarje/makemkv-beta -n -y
#echo "deb http://ppa.launchpadcontent.net/heyarje/makemkv-beta/ubuntu/ jammy main" >  /etc/apt/sources.list.d/heyarje-ubuntu-makemkv-beta-jammy.list
#apt update
#apt install openshot-qt mkvtoolnix-gui makemkv-bin kdenlive -y

# Messenger Microsoft Teams, Telegram, Signal
#snap install teams-for-linux signal-desktop telegram-desktop

#rm /etc/apt/apt.conf.d/01proxy

