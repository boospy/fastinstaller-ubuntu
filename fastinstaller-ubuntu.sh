#!/bin/bash
echo 'Acquire::http { Proxy "http://apt-cacher.osit.cc:3142"; };' | tee /etc/apt/apt.conf.d/01proxy
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 23CAE45582EB0928
echo "deb http://apt.iteas.at/iteas focal main" > /etc/apt/sources.list.d/iteas.list
apt update
apt dist-upgrade -y
apt install ca-certificates-iteas-enterprise -y
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
ubuntu-drivers autoinstall
dpkg -i teamviewer_amd64.deb google-chrome-stable_current_amd64.deb
apt install -fy
apt install zoom master-pdf-editor nomachine ubuntu-restricted-extras vlc soundconverter htop hamsket draw.io strawberry tigervnc-viewer keepassxc cifs-utils nfs-common samba qreator aspell-de hunspell-de-at openfortigui filezilla speedtest-cli gnome-nettool lm-sensors smartmontools flowblade simplescreenrecorder -y
apt remove rhythmbox apport firefox firefox-locale-de firefox-locale-en -y
apt autoremove --purge -y
apt-get clean
rm -rf /home/user
cd /root
wget ftp://data.osit.cc/userprofil-special.tar
tar -xf /root/userprofil-special.tar -C /
rm /root/userprofil-special.tar
rm /etc/apt/apt.conf.d/01proxy
rm /root/.bash_history
rm /root/fastinstaller-ubuntu.sh
apt remove openssh-server -y
apt autoremove --purge -y
echo
echo
echo
echo
lscpu
echo
echo
lsusb
echo
echo
lspci
echo
echo
free -m
echo
echo
echo "fertig ists :)"
#reboot
