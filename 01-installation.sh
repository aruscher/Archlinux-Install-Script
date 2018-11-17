#!/usr/bin/bash

#7 Select mirrors
echo "Select mirrors"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
rm mirrorslist
echo "Download German mirrors"
curl -s "https://www.archlinux.org/mirrorlist/?country=DE&protocol=http&protocol=https&ip_version=4" | sed -e 's/^#Server/Server/' -e '/^#/d' > /etc/pacman.d/mirrorlist

#8 Install base packages
pacstrap /mnt base base-devel vim git
