#!/bin/bash
# A sample Bash script by FAHAD ALGHATHBAR

# Define colors for output
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m" # No Color

echo -e "${GREEN}A sample Bash script by FAHAD ALGHATHBAR${NC}"
log_file="/var/log/update-script.log"
exec &> >(tee -a "$log_file")

# Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}This script must be run as root${NC}" 
   exit 1
fi

echo -e "${GREEN}Starting package update at $(date)${NC}"
echo -e "${YELLOW}########################################################${NC}"

# Update package lists
echo -e "${GREEN}Updating package lists...${NC}"
if ! sudo apt update; then
    echo -e "${RED}Failed to update package lists${NC}"
    exit 1
fi

# Check for upgrades
echo -e "${GREEN}Checking for available upgrades...${NC}"
upgrades=$(sudo apt list --upgradable 2>/dev/null | grep -v -E '(Listing|sources)')
if [ -z "$upgrades" ]; then
    echo -e "${YELLOW}No upgrades available${NC}"
else
    echo -e "${YELLOW}The following packages can be upgraded:${NC}"
    echo "$upgrades"
fi
echo -e "${YELLOW}########################################################${NC}"

# Upgrade packages
echo -e "${GREEN}Upgrading packages...${NC}"
if ! sudo apt upgrade -y; then
    echo -e "${RED}Failed to upgrade packages${NC}"
    exit 1
fi

# Clean package cache
echo -e "${GREEN}Cleaning package cache...${NC}"
if ! sudo apt autoclean; then
    echo -e "${RED}Failed to clean package cache${NC}"
    exit 1
fi

# Remove unused packages
echo -e "${GREEN}Removing unused packages...${NC}"
if ! sudo apt autoremove -y; then
    echo -e "${RED}Failed to remove unused packages${NC}"
    exit 1
fi

# Repair broken packages
echo -e "${GREEN}Checking for and repairing broken packages...${NC}"
if ! sudo apt install -f; then
    echo -e "${RED}Failed to repair broken packages${NC}"
    exit 1
fi

# Update Flatpak packages
echo -e "${GREEN}Updating Flatpak packages...${NC}"
if ! sudo flatpak update -y; then
    echo -e "${RED}Failed to update Flatpak packages${NC}"
    exit 1
fi

echo -e "${GREEN}Package update completed successfully at $(date)${NC}"
echo -e "${YELLOW}########################################################${NC}"
