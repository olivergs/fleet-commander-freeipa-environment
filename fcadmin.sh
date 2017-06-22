#!/bin/bash

if [ ! $UID == 0 ]; then
        echo "Must be root to execute this script"
        exit 1
fi

read -p "Enter IPA Master IP adress: " MASTER_IP
echo ""

echo "Enabling COPR repository for Fleet Commander Admin"
dnf copr enable ogutierrez/fleet-commander-admin -y
echo ""

echo "Cleaning DNF cache"
dnf clean all -y
echo ""

echo "Updating system"
dnf update -y
echo ""

echo "Installing needed packages"
dnf install -y freeipa-client fleet-commander-admin
echo ""

echo "Setup hostname"
echo "fcadmin.fc.ipa" > /etc/hostname ; hostname -F /etc/hostname
hostname
echo ""

echo "Setup DNS resolution"
echo "search fc.ipa" > /etc/resolv.conf
echo "nameserver $MASTER_IP" >> /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
cat /etc/resolv.conf
echo ""

echo "Join FC.IPA realm"
realm join FC.IPA -v
echo ""

echo "Enable cockpit"
systemctl enable cockpit.socket
echo ""

echo "Start cockpit"
systemctl start cockpit
echo ""

