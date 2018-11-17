#!/usr/bin/bash

git clone https://github.com/aruscher/dot-files.git

#Install oh-my-zsh
echo "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Install spacemacs"
sudo pacman -S emacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

echo "Install LISP"
sudo pacman -S sbcl
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

cd ~/dot-files
chmod +x install.sh
./install.sh

emacs
