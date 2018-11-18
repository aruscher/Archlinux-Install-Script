pacman -Sy dialog --noconfirm
USERNAME=$(dialog --title "Archlinux-Setup" --inputbox "User name: " 10 10 --stdout)
PASSWORD=$(dialog --title "Archlinux-Setup" --passwordbox "User password (also root password):" 10 10 --stdout)
HOSTNAME=$(dialog --title "Archlinux-Setup" --inputbox "Host name:" 10 10 --stdout)

echo "Install required packages"
pacman -Sy  go xorg-fonts-{100dpi,75dpi,misc,type1} ttf-hack ttf-dejavu nmap openssh wicd alsa-utils xorg-server xorg-xinit xf86-video-vesa xf86-video-intel xf86-input-synaptics grub os-prober zsh acpid dbus avahi cups cronie emacs sbcl --noconfirm


#11 Set timezone
echo "Set Timezone"
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

#12 Localization
echo "Localization"
echo LANG=en_US.UTF-8 >> /etc/locale.conf
export LANG=en_US.UTF-8
echo KEYMAP=de-latin1 > /etc/vconsole.conf
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
echo de_DE.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen


#13
echo "Set Hostname"
echo $HOSTNAME > /etc/hostname
echo 127.0.0.1 $HOSTNAME >> /etc/hosts
echo 127.0.0.1 localhost >> /etc/hosts

#14 install grub
echo "Install GRUB"
grub-install --recheck /dev/sda 
grub-mkconfig -o /boot/grub/grub.cfg

#15 Mkinitcpio
echo "Run mkinitcpio"
mkinitcpio -p linux

#16 Set root password
echo "Set root password"
echo root:$PASSWORD | chpasswd

# 18 Create User
echo "Set sudoers"
cp /etc/sudoers /etc/sudoers.backup
sed -e "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/" /etc/sudoers.backup > /etc/sudoers

# 19 Create user
useradd -m -g users -s /usr/bin/zsh $USERNAME
echo $USERNAME:$PASSWORD | chpasswd
gpasswd -a $USERNAME wheel
gpasswd -a $USERNAME audio
cp /installer/user-install.sh /home/$USERNAME/
chown andreas:users /home/$USERNAME/user-install.sh


# 20 Install further services
echo "Install further services"
systemctl enable acpid
systemctl enable avahi-daemon
systemctl enable org.cups.cupsd.service
systemctl enable systemd-timesyncd.service
systemctl enable wicd.service
systemctl enable sshd.service
systemctl enable dhcp.service
exit
