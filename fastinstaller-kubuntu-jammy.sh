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
echo
echo
echo -------------------------------------------------------------------------
echo "The next step is to bring your system up to date with a full-upgrade."
echo "It may happen that packages you want to keep are deleted."
echo "Please check the output before continuing!"
echo -------------------------------------------------------------------------
echo
echo
echo "Press ENTER to continue"
read
apt full-upgrade
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
apt install strawberry htop k3b k3b-extrathemes kdf dolphin-nextcloud nfs-common aspell-de hunspell-de-at mpv gnupg-agent kleopatra gnome-icon-theme showfoto kipi-plugins kde-config-cron dolphin-plugins filelight kcolorchooser soundkonverter kcalc partitionmanager kronometer kfind unp kubuntu-restricted-extras katomic avahi-discover simplescreenrecorder avahi-utils tellico language-pack-gnome-de finger konversation usb-creator-kde manpages-de master-pdf-editor-5 draw.io cifs-utils samba speedtest-cli lm-sensors nvme-cli smartmontools kdenetwork-filesharing kipi-plugins digikam plasma-workspace-wayland rustdesk bitwarden thunderbird-locale-de gnome-disk-utility plasma-discover-backend-snap -y


apt remove rhythmbox apport timidity -y

# ZSH-Shell
apt update
apt install zsh git -y
mkdir /usr/share/fonts/truetype/nerdfont && cd /usr/share/fonts/truetype/nerdfont
wget -O /tmp/Sauce_Code_Pro_Nerd_Font_Complete_Mono.ttf https://git.osit.cc/public-projects/zsh-und-bash-configs/raw/master/Sauce_Code_Pro_Nerd_Font_Complete_Mono.ttf
mv /tmp/Sauce_Code_Pro_Nerd_Font_Complete_Mono.ttf /usr/share/fonts/truetype/nerdfont/Sauce_Code_Pro_Nerd_Font_Complete_Mono.ttf
fc-cache -fv
wget -O /root/.zshrc https://git.osit.cc/public-projects/zsh-und-bash-configs/raw/master/zshrc-rootV3
wget -O /etc/skel/.zshrc https://git.osit.cc/public-projects/zsh-und-bash-configs/raw/master/zshrc-userV3
usermod -s /bin/zsh root
wget -O /tmp/nano.tar https://git.osit.cc/public-projects/zsh-und-bash-configs/raw/master/nano_syntax_highlighting.tar
tar -xf /tmp/nano.tar -C /root
tar -xf /tmp/nano.tar -C /etc/skel
rm /tmp/nano.tar -f


# Anpassen der viel zu niedrigen Werte in Sysctl
# Adjusting the much too low values in Sysctl
echo    "fs.file-max = 9223372036854775807" > /etc/sysctl.d/10-OSIT.conf
echo "fs.inotify.max_user_instances = 1024"  >> /etc/sysctl.d/10-OSIT.conf
echo "fs.inotify.max_user_watches = 5242880"  >> /etc/sysctl.d/10-OSIT.conf

# zshfix for Snaps
echo "emulate sh -c 'source /etc/profile'" >> /etc/zsh/zprofile


# ------------------------------------------------------
# Ab hier bitte Dinge einkommentieren die du benötigst:
# From here please comment things you need:
# ------------------------------------------------------

# Wenn du einen Epson Drucker/Scanner betreibst, dann kannst du die Treiberpakete und Software von hier installieren
# If you have an epson printer/scanner, then you can install drivers and software here
#apt install epson-inkjet-printer-escpr epsonscan2 epsonscan2-non-free-plugin -y

# Wenn du einen USB Drucker betreibst, kommentiere die nächste Zeile ein, das deaktiviert die automatische Installation von USB Druckern.
# If you use an USB printer, then comment in the next line, this will be disable the install printer automatic.
#apt purge ipp-usb && apt install libusb-0.1-4 -y

# optional Multimediapackages
#apt-add-repository ppa:heyarje/makemkv-beta -n -y
#echo "deb http://ppa.launchpadcontent.net/heyarje/makemkv-beta/ubuntu/ jammy main" >  /etc/apt/sources.list.d/heyarje-ubuntu-makemkv-beta-jammy.list
#apt update
#apt install openshot-qt mkvtoolnix-gui makemkv-bin kdenlive -y

# Office Alternative, kompatibel zum Microsoftformat
# Office alternative, compatible with Microsoft format
apt install onlyoffice-desktopeditors -y
apt remove libreoffice* --purge -y

# Libreoffice wenn Onlyoffice nicht gewünscht wird
# Libreoffice if Onlyoffice is not desired
#apt install libreoffice-kf5 libreoffice-calc libreoffice-draw libreoffice-impress libreoffice-l10n-de libreoffice-plasma libreoffice-writer libreoffice-templates libreoffice-qt5 -y

# Extra packages
#apt install librecad synaptic tree git audacity -y


# Profi Fotobearbeitung
# Professional photo editing
#apt install gimp gimp-help-de darktable -y

# optional - komplette Kommunikationssuite Kontact, inkl. alle Plugins und Erweiterungen
# optional - complete communication suite Kontact, incl. all plugins and extensions
#apt install kdepim -y

# Kleine Spiele von KDE
# Small games from KDE
#apt install kdegames -y

# optional Virtualbox LTS Version
#apt install virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso -y

# optional Virtualbox 7
#wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
#echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib" > /etc/apt/sources.list.d/virtualbox.list
#apt install virtualbox-7.0 -y

# Messenger
#snap install telegram-desktop zoom-client skype

# Install Microsoft Teams via deb package
#apt install teams-for-linux -y

# Install Signal via deb package
#wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
#cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
#echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | tee /etc/apt/sources.list.d/signal-xenial.list
#apt update
#apt install signal-desktop -y

apt autoremove --purge -y
#rm /etc/apt/apt.conf.d/01proxy
