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

apt install htop k3b k3b-extrathemes kdf dolphin-nextcloud nfs-common aspell-de hunspell-de-at mpv ca-certificates-iteas-enterprise gnupg-agent libreoffice-kf5 libreoffice-calc libreoffice-draw libreoffice-impress libreoffice-l10n-de libreoffice-plasma libreoffice-writer libreoffice-templates libreoffice-qt5 kleopatra gnome-icon-theme yakuake showfoto kipi-plugins kde-config-cron dolphin-plugins filelight kcolorchooser soundkonverter kcalc partitionmanager kronometer kfind unp plasma-theme-oxygen kubuntu-restricted-extras katomic avahi-discover simplescreenrecorder keepassxc avahi-utils tellico language-pack-gnome-de finger konversation filezilla nmapsi4 usb-creator-kde manpages-de master-pdf-editor-5 draw.io cifs-utils samba speedtest-cli lm-sensors smartmontools kdenetwork-filesharing kdenlive kipi-plugins digikam plasma-workspace-wayland -y



apt remove rhythmbox apport timidity -y
snap remove firefox
apt autoremove --purge -y
# rm /etc/apt/apt.conf.d/01proxy

# ZSH-Shell
apt update
apt install zsh git -y
mkdir /usr/share/fonts/truetype/nerdfont && cd /usr/share/fonts/truetype/nerdfont
wget -O /tmp/Sauce_Code_Pro_Nerd_Font_Complete_Mono.ttf https://git.osit.cc/public-projects/zsh-und-bash-configs/raw/master/Sauce_Code_Pro_Nerd_Font_Complete_Mono.ttf
mv /tmp/Sauce_Code_Pro_Nerd_Font_Complete_Mono.ttf /usr/share/fonts/truetype/nerdfont/Sauce_Code_Pro_Nerd_Font_Complete_Mono.ttf
fc-cache -fv
wget -O /root/.zshrc https://git.osit.cc/public-projects/kde-neon-installer/raw/master/zshrc
wget -O /etc/skel/.zshrc https://git.osit.cc/public-projects/kde-neon-installer/raw/master/zshrc
usermod -s /bin/zsh root
wget -O /tmp/nano.tar https://git.osit.cc/public-projects/zsh-und-bash-configs/raw/master/nano_syntax_highlighting.tar
tar -xf /tmp/nano.tar -C /root
tar -xf /tmp/nano.tar -C /etc/skel
rm /tmp/nano.tar -f


# Anpassen der viel zu niedrigen Werte in Sysctl
echo    "fs.file-max = 9223372036854775807" > /etc/sysctl.d/10-OSIT.conf
echo "fs.inotify.max_user_instances = 1024"  >> /etc/sysctl.d/10-OSIT.conf
echo "fs.inotify.max_user_watches = 5242880"  >> /etc/sysctl.d/10-OSIT.conf



# ------------------------------------------------------
# Ab hier bitte Dinge einkommentieren die du benötigst:
# ------------------------------------------------------

# Office Alternative, kompatibel zum Microsoftformat
apt install onlyoffice-desktopeditors -y

# Extra packages
apt install librecad synaptic mpv tree git audacity -y


# Profi Fotobearbeitung
apt install gimp gimp-help-de -y

# optional - komplette Kommunikationssuite Kontact, inkl. alle Plugins und Erweiterungen
# apt install kdepim -y

# optional Advanced Packages
apt install choqok lm-sensors nvme-cli -y

# Kleine Spiele von kdepim
apt install kdegames -y

# optional Virtualbox LTS Version
# apt install virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso -y

