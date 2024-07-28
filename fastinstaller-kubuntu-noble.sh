#!/bin/bash

#
# (c) Mario Loderer, OpenSource-IT
# mario.loderer@osit.cc
#



# Apt Proxy bearbeiten oder einkommentieren
# Edit or comment Apt Proxy
#echo 'Acquire::http { Proxy "http://apt-cacher.osit.cc:3142"; };' | tee /etc/apt/apt.conf.d/01proxy

gpg -k && gpg --no-default-keyring --keyring /usr/share/keyrings/iteas-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 23CAE45582EB0928
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/iteas-keyring.gpg] http://apt.iteas.at/iteas noble main" > /etc/apt/sources.list.d/iteas.list
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
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Brave Secure Browser
#apt install curl -y
#curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
#echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"| tee /etc/apt/sources.list.d/brave-browser-release.list
#apt update
#apt install brave-browser -y

# Ab hier gehts los:

ubuntu-drivers autoinstall

# Standard packages
apt install plasma-runners-addons strawberry htop k3b k3b-extrathemes kdf dolphin-nextcloud nfs-common aspell-de hunspell-de-at mpv kleopatra gnome-icon-theme showfoto kipi-plugins kde-config-cron filelight kcolorchooser soundkonverter kronometer kfind unp kubuntu-restricted-extras simplescreenrecorder avahi-utils tellico finger usb-creator-kde manpages-de master-pdf-editor-5 draw.io cifs-utils samba speedtest-cli lm-sensors nvme-cli kdenetwork-filesharing kipi-plugins digikam plasma-workspace-wayland bitwarden gnome-disk-utility rsibreak tinyotp qtqr language-pack-gnome-de -y


apt remove apport timidity -y

# ZSH-Shell
apt update
apt install zsh git fortunes fortunes-de -y
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

echo "*.local" > /etc/mdns.allow
echo ".local" >> /etc/mdns.allow
echo "iteas.at" >> /etc/mdns.allow
echo "osit.cc" >> /etc/mdns.allow
cp /usr/share/doc/avahi-daemon/examples/s* /etc/avahi/services/.
systemctl restart avahi-daemon.service

# Firefox Snap durch DEB Paket ersetzten
if pgrep -x "firefox" > /dev/null
then
    echo "Bitte Firefox zuerst beenden"
    exit 1
fi

snap remove firefox

if [ ! -e /etc/apt/keyrings ]
then
install -d -m 0755 /etc/apt/keyrings
fi

wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk 'BEGIN{code=0}/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") {print "\nDer Fingeabdruck des Schlüssels stimmt überein: ("$0").\n"} else {print "\nPrüfung fehlgeschlagen: Der Fingerabdruck ("$0") stimmt nicht überein.\n";code=1}} END{exit code}'
if [ $? == 1 ]
then
echo "Abbruch"
exit 1
fi

echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | tee /etc/apt/preferences.d/mozilla

echo 'Unattended-Upgrade::Origins-Pattern {"site=packages.mozilla.org"};' | tee /etc/apt/apt.conf.d/52unattended-upgrades-firefox

apt update && apt -y --allow-downgrades install firefox
apt -y --allow-downgrades install firefox-l10n-de

# ------------------------------------------------------
# Ab hier bitte Dinge einkommentieren die du benötigst:
# From here please comment things you need:
# ------------------------------------------------------

# Wenn du einen Epson Drucker/Scanner betreibst, dann kannst du die Treiberpakete und Software von hier installieren
# If you have an epson printer/scanner, then you can install drivers and software here
#apt install epson-inkjet-printer-escpr epsonscan2 epsonscan2-non-free-plugin -y

# Wenn du einen USB Drucker betreibst und Probleme mit der Automatik hast, kommentiere die nächste Zeile ein, das deaktiviert die automatische Installation von USB Druckern.
# If you are using a USB printer and have problems with the automatic installation, comment in the next line, this will deactivate the automatic installation of USB printers.
#apt purge ipp-usb && apt install libusb-0.1-4 -y

# optional Multimediapackages
#apt-add-repository ppa:heyarje/makemkv-beta -n -y
#apt update
#apt install makemkv-bin -y
#apt install openshot-qt mkvtoolnix-gui kdenlive -y

# Remote Service
#apt install rustdesk -y
#apt install nomachine -y

# Office Alternative, kompatibel zum Microsoftformat
# Office alternative, compatible with Microsoft format
apt install onlyoffice-desktopeditors -y
apt remove libreoffice* --purge -y

# Libreoffice wenn Onlyoffice nicht gewünscht wird
# Libreoffice if Onlyoffice is not desired
#apt install libreoffice-templates libreoffice-help-de -y

# Extra packages
#apt install librecad synaptic tree git audacity -y

# Profi Fotobearbeitung
# Professional photo editing
#apt install gimp gimp-help-de darktable -y

# optional - komplette Kommunikationssuite Kontact, inkl. alle Plugins und Erweiterungen
# optional - complete communication suite Kontact, incl. all plugins and extensions
#apt install kdepim -y

# Kleine Spiele von KDE und Klassiker
# Small games from KDE and classics
apt install kdegames supertux supertuxkart -y

# optional Virtualbox LTS Version
#apt install virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso -y

# Messenger
#snap install telegram-desktop zoom-client skype

# Install Microsoft Teams via deb package
#apt install teams-for-linux -y

# Install Signal via deb package
#wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
#cat signal-desktop-keyring.gpg | tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
#echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | tee /etc/apt/sources.list.d/signal-xenial.list
#apt update
#apt install signal-desktop -y

# UCS Univention Domänenanbindung
# UCS Univention Domain Connection
#add-apt-repository ppa:univention-dev/ppa -n -y

# Installation des UCS Clients für Kerberos/AD Anbindung an Univention Server
# Installation of the UCS client for Kerberos/AD connection to Univention server
#DEBIAN_FRONTEND=noninteractive apt-get install univention-domain-join krb5-auth-dialog -y

# Entwickler und Administratoren
# Developers and Administrators
#apt install nload openfortigui openfortigui-runner virt-viewer pwgen konversation ldap-utils filezilla realvnc-vnc-viewer mactelnet-client preload krename kompare wireshark gtkterm xca libpam-mount davfs2 keyutils okteta manpages-de-dev php-mbstring composer dbeaver-ce rpi-imager zenmap -y

apt autoremove --purge -y
#rm /etc/apt/apt.conf.d/01proxy
