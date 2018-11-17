#!/usr/bin/bash

DRIVE_NAME="sda"
KEY_LAYOUT="de-latin1"
DRIVE_SIZE=30
MAX_ROOT_SIZE=50
MIN_HOME_SIZE=10
RAM_SIZE=8

DRIVE="/dev/$DRIVE_NAME"


# 1 Loadkeys
echo "Set Keylayout"
loadkeys $KEY_LAYOUT

#2 Check internet connection
echo "Checking internet connection"
ping google.de -c 1
echo $?

if [ $? -eq 0 ]
then
    echo "Found internet connection"
else
   echo "No internet connection found. Please connect and rerun this script"
   exit
fi

#3 Update system clock
echo "Update system clock"
timedatectl set-ntp true

#4 Create Partitions
echo "Create Partitions"
rm sfdisk.in
touch sfdisk.in
ROOT_SIZE=$(python -c "print(min($MAX_ROOT_SIZE,$DRIVE_SIZE-$RAM_SIZE-$MIN_HOME_SIZE))")
echo ,$ROOT_SIZE\G,L,+ >> sfdisk.in
echo ,$RAM_SIZE\G,S, >> sfdisk.in
echo ,,L, >> sfdisk.in
sfdisk $DRIVE < sfdisk.in

#5 Format partitions
echo "Format Partitions"
mkfs.ext4 $DRIVE\1
mkfs.ext4 $DRIVE\3
mkswap $DRIVE\2
swapon $DRIVE\2

#6 Mount partitions
echo "Mount Partitions"
mount $DRIVE\1 /mnt
mkdir /mnt/home
mount $DRIVE\3 /mnt/home


