#!/bin/bash

#StopVM
VBoxManage controlvm 9f388dfd-78fe-4900-bfba-36d7170bfbef poweroff
sleep 1
VBoxManage snapshot 9f388dfd-78fe-4900-bfba-36d7170bfbef restore After-Installation
sleep 1
VBoxManage startvm 9f388dfd-78fe-4900-bfba-36d7170bfbef

./upload-files.sh

#Test installation
sshpass -p "q2u2u4505" ssh root@127.0.0.1 -p 3022 -t "chmod +x 02-configure-system.sh | sudo ./02-configure-system.sh"
VBoxManage snapshot 9f388dfd-78fe-4900-bfba-36d7170bfbef delete "After-Configure-System"
VBoxManage snapshot 9f388dfd-78fe-4900-bfba-36d7170bfbef take "After-Configure-System"
