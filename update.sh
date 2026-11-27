#!/bin/bash
# A sample Bash script by FAHAD ALGHATHBAR

# Define colors for output
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m" # No Color

# Ensure script is run as root (before writing the log in /var/log)
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}This script must be run as root (try: sudo $0)${NC}"
   exit 1
fi

echo -e "${GREEN}A sample Bash script by FAHAD ALGHATHBAR${NC}"
log_file="/var/log/update-script.log"
exec &> >(tee -a "$log_file")

export DEBIAN_FRONTEND=noninteractive

echo -e "${GREEN}Starting package update at $(date)${NC}"
echo -e "${YELLOW}########################################################${NC}"

# Update package lists
echo -e "${GREEN}Updating package lists...${NC}"
if ! apt-get update; then
    echo -e "${RED}Failed to update package lists${NC}"
    exit 1
fi

# Check for upgrades
echo -e "${GREEN}Checking for available upgrades...${NC}"
upgrades=$(apt list --upgradable 2>/dev/null | grep -v '^Listing')
if [ -z "$upgrades" ]; then
    echo -e "${YELLOW}No upgrades available${NC}"
else
    echo -e "${YELLOW}The following packages can be upgraded:${NC}"
    echo "$upgrades"
fi
echo -e "${YELLOW}########################################################${NC}"

# Repair broken packages first, so the upgrade can run
echo -e "${GREEN}Checking for and repairing broken packages...${NC}"
if ! apt-get install -f -y; then
    echo -e "${RED}Failed to repair broken packages${NC}"
    exit 1
fi

# Upgrade packages
echo -e "${GREEN}Upgrading packages...${NC}"
if ! apt-get upgrade -y; then
    echo -e "${RED}Failed to upgrade packages${NC}"
    exit 1
fi

# Remove unused packages
echo -e "${GREEN}Removing unused packages...${NC}"
if ! apt-get autoremove -y; then
    echo -e "${RED}Failed to remove unused packages${NC}"
    exit 1
fi

# Clean package cache
echo -e "${GREEN}Cleaning package cache...${NC}"
if ! apt-get autoclean; then
    echo -e "${RED}Failed to clean package cache${NC}"
    exit 1
fi

# Update Flatpak packages (only if Flatpak is installed)
if command -v flatpak > /dev/null 2>&1; then
    echo -e "${GREEN}Updating Flatpak packages...${NC}"
    if ! flatpak update -y; then
        echo -e "${RED}Failed to update Flatpak packages${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}Flatpak not installed, skipping${NC}"
fi

echo -e "${GREEN}Package update completed successfully at $(date)${NC}"
echo -e "${YELLOW}########################################################${NC}"
