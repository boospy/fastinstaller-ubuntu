Fastinstaller-Ubuntu-Kubuntu (noble and older Jammy)
====================================

**You would like to show your appreciation for our help 8-o. Gladly. We thank you for your donation! ;)**

<a href="https://www.paypal.com/donate/?hosted_button_id=JTFYJYVH37MNE">
  <img src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif">
</a>

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/L3L813B3CV)

The script installs after the standard installation of Ubuntu/Kubuntu, selected application to it and configures the system for an optimal operability. You can change everything in this script as you like. If you don't want to have something, then comment out the relevant area with "#". Or if you want to activate something, remove the "#" from that area.

# What does it exactly do at default with no changes of the script?

  * Add ITEAS enterprise repository https://apt.iteas.at
  * Add brave-browser repository and install the brave-browser for more security
  * Install all ca-certifactes from iteas-enterprise
  * Update the whole System
  * Install thirdpartdrivers with ubuntu-drivers
  * Adjusting the much too low values in sysctl (only Kubuntu)
  * Install special nerdfont for ZSH as defaultshell
  * Add nano syntax highlighting
  * Set zshfix for snaps (only Kubuntu)

### The following packages will be uninstalled
  
  * apport
  * rhythmbox
  * libreoffice suite
  * timidity (only Kubuntu)
  
### The following packages will be installed on Kubuntu
[fastinstaller-kubuntu-noble.sh](https://github.com/boospy/fastinstaller-ubuntu/blob/master/fastinstaller-kubuntu-noble.sh)

<img src="https://raw.githubusercontent.com/boospy/fastinstaller-ubuntu/master/kubuntu-installer.png" width="" height="100">

  * strawberry (Music management)
  * htop
  * k3b
  * k3b-extrathemes
  * kdf
  * dolphin-nextcloud
  * nfs-common
  * aspell-de
  * hunspell-de-at
  * mpv
  * gnupg-agent
  * kleopatra (key and certmanagement for KDE)
  * gnome-icon-theme
  * showfoto
  * kipi-plugins
  * kde-config-cron
  * dolphin-plugins
  * filelight
  * kcolorchooser
  * soundkonverter
  * kcalc
  * partitionmanager
  * kronometer
  * kfind
  * unp (unzipfrontend for CMD)
  * kubuntu-restricted-extras
  * katomic (little game)
  * avahi-discover
  * simplescreenrecorder (record everything on your screen)
  * avahi-utils
  * tellico
  * language-pack-gnome-de
  * finger
  * konversation
  * usb-creator-kde
  * manpages-de
  * master-pdf-editor-5  (edit your pdf documents)
  * draw.io
  * cifs-utils
  * samba
  * speedtest-cli
  * lm-sensors
  * nvme-cli
  * smartmontools
  * kdenetwork-filesharing
  * kipi-plugins
  * digikam (Photo management)
  * plasma-workspace-wayland
  * rustdesk (remote adminstration)
  * bitwarden (password management)
  * onlyoffice-desktopeditors (replaces libreoffice)

### The following packages will be installed on Ubuntu
[fastinstaller-ubuntu-noble.sh](https://github.com/boospy/fastinstaller-ubuntu/blob/master/fastinstaller-ubuntu-noble.sh)
  
<img src="https://raw.githubusercontent.com/boospy/fastinstaller-ubuntu/master/ubuntu-installer.png" width="" height="100"> 
  
  * master-pdf-editor-5  (edit your pdf documents)
  * ubuntu-restricted-extras
  * vlc
  * soundconverter
  * htop
  * draw.io
  * bitwarden (password management)
  * cifs-utils
  * nfs-common
  * samba
  * aspell-de
  * hunspell-de-at
  * filezilla
  * speedtest-cli
  * gnome-nettool
  * lm-sensors
  * smartmontools
  * flowblade
  * simplescreenrecorder  (record everything on your screen)
  * strawberry (Music management)
  * rustdesk (remote adminstration)
  
# And you can choose from the following options in the script

  * Set an apt-acher or squid-deb-proxy
  * Install Google Chrome
  * choose Libreoffice instead of Onlyoffice
  * Extra packages librecad, synaptic, tree, git and audacity
  * complete communication suite Kontact, incl. all plugins and extensions (only Kubuntu)
  * Small games from KDE (only Kubuntu)
  * Add MakeMKV repository (multimedia save your DVD and Blurays) with openshot-qt,  mkvtoolnix-gui and kdenlive
  * optional Virtualbox LTS Version (only Kubuntu)
  * Messenger Microsoft Teams, Telegram, Signal
  * Professional photo editing with Gimp and Darktable


INSTALLATION
------------

Run the following commands with SUDO or in a rootshell. You can customize the file before you run it as described above.

### Kbuntu

~~~
wget https://raw.githubusercontent.com/boospy/fastinstaller-ubuntu/master/fastinstaller-kubuntu-noble.sh
chmod +x fastinstaller-kubuntu-noble.sh
./fastinstaller-kubuntu-noble.sh
~~~

### Ubuntu

~~~
wget https://raw.githubusercontent.com/boospy/fastinstaller-ubuntu/master/fastinstaller-ubuntu-noble.sh
chmod +x fastinstaller-ubuntu-noble.sh
./fastinstaller-ubuntu-noble.sh
~~~

  
                 (__) 
                 (oo) 
           /------\/ 
          / |    ||   
         *  /\---/\ 
            ~~   ~~   
..."Have you mooed today?"...
