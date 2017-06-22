#!/bin/bash

if [ ! $UID == 0 ]; then
        echo "Must be root to execute this script"
        exit 1
fi

read -p "Enter IPA Master IP adress: " MASTER_IP
echo ""

echo "Enabling COPR repository for SSSD"
dnf copr enable fidencio/deskprofile -y
echo ""

echo "Enabling COPR repository for Fleet Commander Client"
dnf copr enable ogutierrez/fleet-commander-client -y
echo ""

echo "Cleaning DNF cache"
dnf clean all -y
echo ""

echo "Updating system"
dnf update -y
echo ""

echo "Installing needed packages"
dnf install -y freeipa-client sssd fleet-commander-client
echo ""

echo "Setup hostname"
echo "fcclient.fc.ipa" > /etc/hostname ; hostname -F /etc/hostname
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

echo "Setting up SSSD"
mkdir -p /usr/share/fleetcommander/
echo "[domain/ipa.example]" > /usr/share/fleetcommander/sssd.snippet.conf
echo "ipa_enable_deskprofile = True" >> /usr/share/fleetcommander/sssd.snippet.conf
chmod 400 /usr/share/fleetcommander/sssd.snippet.conf
systemctl start sssd-deskprofile.service
echo ""


