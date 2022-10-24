# manjaro-post-install
# Things to do after installing Manjaro Linux
# Run this file with sudo! 

#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run with sudo, sudo ./run.sh"
  exit
fi
echo "Remember current user $u before reboot"
u=$(logname)
echo "${u}" > user.log

echo "1. Updating mirrors and Manjaro"
#pacman-mirrors --geoip ; yes | pacman -Syyu #OLD WAY Max retries exceeded with url: /v1/ip/country/full
#pacman-mirrors --fasttrack 
pacman-mirrors --country United_States
yes | pacman -Syyu

echo "2. Install goodies | Basic packages"
yes | pacman -Sy htop bmon whois yay ufw git base-devel nmap gnome-disk-utility

echo "3. Install base-devel for using yay and building packages with AUR"
yes | pacman -Sy autoconf automake binutils bison fakeroot file findutils flex gawk gcc gettext grep groff gzip libtool m4 make pacman patch pkgconf sed sudo systemd texinfo util-linux which 

echo "3. Install Standard desktop packages"
yes | yay -S google-chrome vlc steam fish aspell-en libmythes mythes-en languagetool traceroute putty file-roller seahorse-nautilus nautilus-share zlib p7zip unzip zip zziplib visual-studio-code jdk python-pip audacity unetbootin steam gimp pencil2d ark adwaita-icon-theme adwaita-maia anydesk-bin archlinux-appstream-data archlinux-keyring argon2 at-spi2-atk at-spi2-core atk atkmm autoconf automake bleachbit bluez bluez-libs bmenu bolt boost-libs brave-browser brotli btrfs-progs btrfsmaintenance bubblewrap bzip2 cairo cairomm calamares-tools cantarell-fonts cdparanoia celt chromaprint cifs-utils compiler-rt confuse coreutils cpupower deepin-icon-theme deepin-iconthemes-manjaro deja-dup desktop-file-utils device-mapper zsh vim binutils make curl gcc fakeroot vmware-workstation — noconfirm — needed


echo "You can login after this reboot"

echo "Getting IP and Timezone info"
ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
timezone=$(curl https://ipapi.co/$ip/timezone)
timedatectl set-timezone $timezone
timedatectl set-ntp true
echo "Got $timezone from $ip"

echo "All done - Rebooting"
reboot now
