#!/bin/bash
cat /etc/os-release 
apt-get update
mkdir /custom
echo "custom code" > /custom/file.txt
#apt-get install -y apache2
#systemctl enable apache2
