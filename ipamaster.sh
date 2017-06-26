#!/bin/bash

if [ ! $UID == 0 ]; then
        echo "Must be root to execute this script"
        exit 1
fi

echo "Updating system"
dnf update -y
echo ""

echo "Installing needed packages"
dnf install -y @freeipa-server oddjob-mkhomedir freeipa-desktop-profile
echo ""

echo "Setup hostname"
echo "master.fc.ipa" > /etc/hostname ; hostname -F /etc/hostname
hostname
echo ""

echo "Get IP address"
MASTER_IP=$(/sbin/ifconfig ens3 | grep "inet\ " | awk '{print $2}')
echo $MASTER_IP
echo ""

echo "Setup DNS resolution"
echo "search fc.ipa" > /etc/resolv.conf
echo "nameserver $MASTER_IP" >> /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
cat /etc/resolv.conf
echo ""

echo "Open firewall ports"
for x in dns freeipa-ldap freeipa-ldaps freeipa-replication; do firewall-cmd --permanent --zone=FedoraWorkstation --add-service=${x} ; done
echo ""

echo "Restart firewall service"
systemctl reload firewalld.service
echo ""

echo "Install IPA Server"
ipa-server-install --ssh-trust-dns --setup-dns --idstart=50000 --idmax=99999 --mkhomedir
echo ""

echo "DONT FORGET SETUP THIS MACHINE WITH FIXED IP ADDRESS"
