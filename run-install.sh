#!/usr/bin/bash


echo "Run Pre-Installation"
chmod +x  00-pre-installation.sh
./00-pre-installation.sh

echo "Run Installation"
chmod +x 01-installation.sh
./01-installation.sh

echo "Run Configure System"
chmod +x 02-configure-system.sh
./02-configure-system.sh
