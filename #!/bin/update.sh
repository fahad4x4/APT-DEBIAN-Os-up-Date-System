#!/bin/bash
# A sample Bash script FAHAD ALGHATHBAR

echo "A sample Bash script By - FAHAD ALGHATHBAR"
log_file="/var/log/update-script.log"
exec &> >(tee -a "$log_file")

# Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "Starting package update at $(date)"
echo "########################################################"

# Update package lists
echo "Updating package lists..."
if ! sudo apt update; then
    echo "Failed to update package lists"
    exit 1
fi

# Check for upgrades
echo "Checking for available upgrades..."
upgrades=$(sudo apt list --upgradable 2>/dev/null | grep -v -E '(Listing|sources)')
if [ -z "$upgrades" ]; then
    echo "No upgrades available"
else
    echo "The following packages can be upgraded:"
    echo "$upgrades"
fi
echo "########################################################"

# Upgrade packages
echo "Upgrading packages..."
if ! sudo apt upgrade -y; then
    echo "Failed to upgrade packages"
    exit 1
fi

# Clean package cache
echo "Cleaning package cache..."
if ! sudo apt autoclean; then
    echo "Failed to clean package cache"
    exit 1
fi

# Remove unused packages
echo "Removing unused packages..."
if ! sudo apt autoremove -y; then
    echo "Failed to remove unused packages"
    exit 1
fi

# Repair broken packages
echo "Checking for and repairing broken packages..."
if ! sudo apt install -f; then
    echo "Failed to repair broken packages"
    exit 1
fi

# Update Flatpak packages
echo "Updating Flatpak packages..."
if ! sudo flatpak update -y; then
    echo "Failed to update Flatpak packages"
    exit 1
fi

echo "Package update completed successfully at $(date)"
echo "########################################################"
