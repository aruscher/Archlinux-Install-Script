#!/usr/bin/bash

#10 Chroot into the new system
echo "Chroot into the new system"
rm -rf /mnt/installer
mkdir /mnt/installer

cp ./my-chroot.sh /mnt/installer/
cp ./user-install.sh /mnt/installer
chmod +x /mnt/installer/my-chroot.sh
arch-chroot /mnt /installer/my-chroot.sh

rm -rf /mnt/installer
reboot
