#!/usr/bin/bash

DRIVE="dev/sda"
KEY_LAYOUT="de-latin1"



# 1 Loadkeys
echo "Set Keylayout"
loadkeys $KEY_LAYOUT

#2 Check internet connection
echo "Checking internet connection"
ping google.de -c 1

if [ $? -eq 0 ]; then
   echo "No internet connection found. Please connect and rerun this script"
   exit
fi
