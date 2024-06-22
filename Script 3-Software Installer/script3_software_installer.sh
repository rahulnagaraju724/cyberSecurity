#!/bin/bash

# Script: script3_software_installer.sh
# Purpose: To automate the installation of specified software packages
# Author: Rahul Nagaraju
# Date: August 31, 2023

# Software packages to be installed.
software_packages=("apache" "git" "vim" "curl" "htop" )

: <<COMMENT | tee -a installation_results.txt
This script automates the installation of the below packages

1. Server:
Apache: It is a well-known web server software used to host websites and web applications.

2. Version control:
git: Distributed version control for collaborative coding.

3. Text Editor:
vim: Efficient, extensible text editor for coding in terminals.

4. Other tools
curl: Command-line data transfer tool for web services.
htop: Interactive process viewer for system resources.
COMMENT

echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Starting Installation Script >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" | tee -a installation_results.txt

# Verify if the script is executed with superuser privileges (sudo).
if [ "$EUID" -ne 0 ]; then
    echo "You need superuser privileges (sudo) to run this script." | tee -a installation_results.txt
    exit 1
fi

# Function to determine if a software package is already installed on the system.
is_package_already_installed() {
    # Use the 'dpkg' command to list installed packages and 'grep' to search for the specified package name.
    dpkg -l | grep -q $1
}

# Function to install a software package if it's not currently installed.
install_package() {
    if ! is_package_already_installed $1; then
        # Update the system's package database and proceed with the installation of the specified package.
        apt-get update 2>&1 | tee -a installation_results.txt
        apt-get install -y $1 2>&1 | tee -a installation_results.txt
    else
        # Inform the user that the package is already present on the system.
        echo "$1 is already present." | tee -a installation_results.txt
    fi
}

# Iterate through the list and initiate the installation process for each package.
for package in "${software_packages[@]}"; do

    echo "----------------------------" | tee -a installation_results.txt
    echo "Installing package: $package" | tee -a installation_results.txt

    # Check whether the package is already installed.
    if is_package_already_installed "$package"; then
        echo "$package is already installed." | tee -a installation_results.txt
    else
        echo "Commencing the installation of $package..." | tee -a installation_results.txt
        install_package "$package"

        # Confirm if the installation process was successful.
        if is_package_already_installed "$package"; then
            echo "$package has been successfully installed." | tee -a installation_results.txt
        else
            echo "The installation of $package has encountered an issue. Please review for errors." | tee -a installation_results.txt
        fi
    fi

    echo "----------------------------" | tee -a installation_results.txt
    echo | tee -a installation_results.txt
done

echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< End of Script >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" | tee -a installation_results.txt
# End of Script

