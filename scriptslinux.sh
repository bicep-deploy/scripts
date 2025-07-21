#!/bin/bash
cat /etc/os-release 
apt-get update
apt-get install -y apache2
systemctl enable apache2
