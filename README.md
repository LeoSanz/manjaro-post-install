# manjaro-post-install
This is a personal project to automate all the steps to take on a brand new Manjaro install

# Things to do after installing Manjaro Linux
 ```git clone https://github.com/LeoSanz/manjaro-post-install ; cd manjaro-post-install ; chmod +x run.sh ; sudo ./run.sh```
 
 # Run run.sh with sudo!
```
# manjaro-post-install
# Things to do after installing Manjaro Linux
# Run this file with sudo! 

#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run with sudo, sudo ./run.sh"
  exit
fi
echo "Hi, just two questions to start!"
read -p 'What hostname should we use for this machine?: ' hostname
if [[ -z "$hostname" ]]; then
   printf '%s\n' "No hostname entered"
   exit 1
else
   printf "You entered %s " "$hostname"
   hostnamectl set-hostname $hostname ; echo ""
fi

while true; do
printf ""
read -p "Keep Manjaro XFCE GUI - do you need a screen? (y/n) " yn
    case $yn in
        [Yy]* ) gui="1"; break;;
        [Nn]* ) gui="2"; break;;
        * ) echo "Please answer yes(y) or no(n).";;
    esac
done

echo "Remember current user $u before reboot"
u=$(logname)
echo "${u}" > user.log

echo "1. Updating mirrors and Manjaro"
#pacman-mirrors --geoip ; yes | pacman -Syyu #OLD WAY Max retries exceeded with url: /v1/ip/country/full
#pacman-mirrors --fasttrack 
pacman-mirrors --country United_States
yes | pacman -Syyu

echo "2. Install goodies | ntp docker docker-compose glances htop bmon jq whois yay ufw fail2ban git bc nmap smartmontools gnome-disk-utility"
yes | pacman -Sy mdadm libqalculate dialog ncdu msr-tools ddrescue pigz screen haproxy net-tools ntp docker docker-compose glances htop bmon jq whois yay ufw fail2ban git bc nmap smartmontools qemu-guest-agent iotop gnome-disk-utility

echo "3. Install base-devel for using yay and building packages with AUR"
yes | pacman -Sy autoconf automake binutils bison fakeroot file findutils flex gawk gcc gettext grep groff gzip libtool m4 make pacman patch pkgconf sed sudo systemd texinfo util-linux which 


echo "You can login after this reboot"


## Pretty MOTD BANNER
if [ -z "${NO_MOTD_BANNER}" ] ; then
  if ! grep -q https "/etc/motd" ; then
    cat << 'EOF' > /etc/motd.new	   

EOF
    cat /etc/motd >> /etc/motd.new
    mv /etc/motd.new /etc/motd
  fi
fi
echo "Getting IP and Timezone info"
ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
timezone=$(curl https://ipapi.co/$ip/timezone)
timedatectl set-timezone $timezone
timedatectl set-ntp true
echo "Got $timezone from $ip"
echo "All done - Rebooting"
reboot now
```
