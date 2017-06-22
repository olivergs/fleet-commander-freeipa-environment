#!/bin/bash

if [ ! $UID == 0 ]; then
        echo "Must be root to execute this script"
        exit 1
fi

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
dnf install -y  fleet-commander-logger
echo ""
