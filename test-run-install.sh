#!/bin/bash

#StopVM
VBoxManage controlvm 9f388dfd-78fe-4900-bfba-36d7170bfbef poweroff
sleep 1
VBoxManage snapshot 9f388dfd-78fe-4900-bfba-36d7170bfbef restore RDY
sleep 1
VBoxManage startvm 9f388dfd-78fe-4900-bfba-36d7170bfbef

./upload-files.sh

#Test installation
./test-00-preinstallation.sh
./test-01-installation.sh
./test-02-configure-system.sh
