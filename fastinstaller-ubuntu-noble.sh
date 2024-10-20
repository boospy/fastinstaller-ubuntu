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
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#apt install ./google-chrome-stable_current_amd64.deb
#rm google-chrome-stable_current_amd64.deb

# Brave Secure Browser
apt install curl -y
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"| tee /etc/apt/sources.list.d/brave-browser-release.list
apt update
apt install brave-browser -y


ubuntu-drivers autoinstall

# Standard packages
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
apt install master-pdf-editor-5 ubuntu-restricted-extras soundconverter htop draw.io bitwarden cifs-utils nfs-common samba aspell-de hunspell-de-at speedtest-cli gnome-nettool lm-sensors smartmontools flowblade simplescreenrecorder mpv unp avahi-utils finger nvme-cli tinyotp rsibreak qtqr -y

apt remove apport -y
apt autoremove --purge -y

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

# zshfix for Snaps
echo "emulate sh -c 'source /etc/profile'" >> /etc/zsh/zprofile

echo "*.local" > /etc/mdns.allow
echo ".local" >> /etc/mdns.allow
echo "v-source.org" >> /etc/mdns.allow
echo "osit.cc" >> /etc/mdns.allow
cp /usr/share/doc/avahi-daemon/examples/s* /etc/avahi/services/.
systemctl restart avahi-daemon.service

# Firefox Snap durch DEB Paket ersetzten
# Firefox Snap replaced by DEB package
echo "Solltest du Firefox noch geöffnet haben, schließen ihn jetzt."
echo "If you still have Firefox open, close it now."
echo
echo "Press ENTER to continue"
echo
read
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

# Wenn du einen USB Drucker betreibst, kommentiere die nächste Zeile ein, das deaktiviert die automatische Installation von USB Druckern.
# If you use an USB printer, then comment in the next line, this will be disable the install printer automatic.
#apt purge ipp-usb -y && apt install libusb-0.1-4 -y

# Office Alternative, kompatibel zum Microsoftformat
# Office alternative, compatible with Microsoft format
apt install onlyoffice-desktopeditors -y
apt remove libreoffice* --purge -y

# Extra packages
#apt install librecad synaptic tree git audacity gparted -y

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
#apt install makemkv-bin -y
#apt install openshot-qt mkvtoolnix-gui -y

# Remote Service
apt install rustdesk -y
#apt install nomachine -y

# Kleine Gnome-Spiele und Klassiker
# Small gnome-games and classics
apt install gnome-games supertux supertuxkart -y

# optional Virtualbox LTS Version
#apt install virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso -y

#snap set system store-certs.cert1="$(cat /usr/local/share/ca-certificates/fortinet-deepinspection-osit2.crt)"
#snap get system store-certs

# Messenger
#snap install telegram-desktop zoom-client skype element-destkop

# Install Microsoft Teams via deb package
#apt install teams-for-linux -y

# Install Signal via snap package
#snap install signal-desktop

# Install Signal via deb package
#wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
#cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
#echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | tee /etc/apt/sources.list.d/signal-xenial.list
#apt update
#apt install signal-desktop -y

# UCS Univention Domänenanbindung (ist der Zeit noch nicht für 24.04 verfügbar), aber es funktionieren die Pakete für Jammy.
# UCS Univention Domain Connection (is not available this time for 24.04), but the packages for jammy are working fine.
#add-apt-repository ppa:univention-dev/ppa -n -y

# Installation des UCS Clients für Kerberos/AD Anbindung an Univention Server
# Installation of the UCS client for Kerberos/AD connection to Univention server
#DEBIAN_FRONTEND=noninteractive apt-get install univention-domain-join krb5-auth-dialog -y

# Entwickler und Administratoren
# Developers and Administrators
#apt install nload openfortigui openfortigui-runner virt-viewer pwgen konversation ldap-utils filezilla realvnc-vnc-viewer mactelnet-client preload krename kompare wireshark gtkterm xca libpam-mount davfs2 keyutils okteta manpages-de-dev php-mbstring composer dbeaver-ce rpi-imager zenmap -y

apt autoremove --purge -y
#rm /etc/apt/apt.conf.d/01proxy

