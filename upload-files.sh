#!/bin/bash

# Copy file
sshpass -p "q2u2u4505" scp  -P 3022 00-pre-installation.sh root@127.0.0.1:~
sshpass -p "q2u2u4505" scp  -P 3022 01-installation.sh root@127.0.0.1:~
sshpass -p "q2u2u4505" scp  -P 3022 02-configure-system.sh root@127.0.0.1:~
sshpass -p "q2u2u4505" scp  -P 3022 my-chroot.sh root@127.0.0.1:~
sshpass -p "q2u2u4505" scp  -P 3022 user-install.sh root@127.0.0.1:~
sshpass -p "q2u2u4505" scp  -P 3022 run-install.sh root@127.0.0.1:~
