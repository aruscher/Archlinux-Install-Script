#!/bin/bash

#StopVM
VBoxManage controlvm 9f388dfd-78fe-4900-bfba-36d7170bfbef poweroff
sleep 1
VBoxManage snapshot 9f388dfd-78fe-4900-bfba-36d7170bfbef restore RDY
sleep 1
VBoxManage startvm 9f388dfd-78fe-4900-bfba-36d7170bfbef

./upload-files.sh

#Test installation
sshpass -p "q2u2u4505" ssh root@127.0.0.1 -p 3022 -t "chmod +x 00-pre-installation.sh | ./00-pre-installation.sh"

VBoxManage snapshot 9f388dfd-78fe-4900-bfba-36d7170bfbef delete "After-Pre-Installation"
VBoxManage snapshot 9f388dfd-78fe-4900-bfba-36d7170bfbef take "After-Pre-Installation"
