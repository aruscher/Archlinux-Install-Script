#!/usr/bin/bash

#Keymap for X11
#echo "Set Keymap for X11"
#sudo localectl set-x11-keymap de pc105 nodeadkeys

#echo "Blacklist Pcspkr"
#sudo blacklist pcspkr

echo "Install AUR helper: yay"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~

#Install oh-my-zsh
echo "Install oh-my-zsh"
yay -S oh-my-zsh-git

echo "Install spacemacs"
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

echo "Install LISP"
mkdir tmp
cd tmp
curl -O https://beta.quicklisp.org/quicklisp.lisp
sbcl --load quicklisp.lisp \
     --eval '(quicklisp-quickstart:install)'\
     --eval '(ql:add-to-init-file)'\
     --eval '(quit)'


echo "Install stumpwm"
sbcl --eval '(ql:quickload "clx")'\
     --eval '(ql:quickload "cl-ppcre")'\
     --eval '(ql:quickload "alexandria")'\
     --eval '(ql:quickload "swank")'\
     --eval '(quit)'

cd ~
export SBCL_HOME=/usr/lib/sbcl/
git clone https://github.com/stumpwm/stumpwm.git
cd stumpwm
autoconf
./configure
make
sudo make install
cd ~
echo $(which stumpwm) >> ~/.xinitrc



git clone https://github.com/aruscher/dot-files.git
cd ~/dot-files
chmod +x install.sh
./install.sh
