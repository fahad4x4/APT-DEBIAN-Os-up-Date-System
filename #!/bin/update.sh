#!/bin/bash
# A sample Bash script FAHAD ALGHATHBAR

echo "Updating package lists"
sudo apt update
echo "########################################################"

echo "Upgrading packages"
sudo apt upgrade -y
echo "########################################################"

echo "Cleaning package cache"
sudo apt autoclean
echo "########################################################"

echo "Removing unused packages"
sudo apt autoremove -y
echo "########################################################"

echo "Updating Flatpak packages"
sudo flatpak update -y
echo "########################################################"
