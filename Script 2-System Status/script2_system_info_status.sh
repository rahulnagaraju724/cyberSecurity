#!/bin/bash

# Script: script2_system_info_status.sh
# Purpose: Fetch and display system information and status
# Author: Rahul Nagaraju
# Date: August 31, 2023

# Fetch the active user
active_user=$(whoami)

# Fetch the uptime
uptime=$(uptime -s)

# Fetch the hostname of the system
hostname=$(hostname)

# Fetch the main IP address of the host
hostIP=$(hostname -I)

# Fetch the kernel version
kernel_version=$(uname -r)

# Fetch detailed CPU usage information

# Use mpstat to get per-core CPU usage percentages for one second, one time
cpu_info=$(mpstat -P ALL 1 1 | awk 'NF{if ($1 ~ /^[0-9]+$/) {core = $1} else {print "Core " core ": " $3"% user, " $5"% system, " $13"% idle"}}')

# Fetch system status

# Get detailed memory information using free
memory_info=$(free -m)

# Get detailed disk usage information using df for the root partition
disk_info=$(df -h /)

# Get network statistics using netstat
network_stats=$(netstat -i)

# Redirect all output to results.txt and also display it on the terminal
exec > results.txt

#Fetch system information
echo "This program's purpose is to fetch system information and status"
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< System Information and Status >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo "Hostname: $hostname"
echo "Kernel Version: $kernel_version"
echo "Current User: $active_user"
echo "System is running since: $uptime"
echo

# Print CPU usage information
echo "CPU Usage (per core):"
echo "-----------------------"
echo "$cpu_info"
echo

# Print memory information
echo "Memory Information:"
echo "-------------------"
echo "$memory_info"
echo

# Print disk usage information
echo "Disk Usage (root partition):"
echo "---------------------------"
echo "$disk_info"
echo

# Print network statistics (netstat)
echo "Network Statistics:"
echo "-------------------"
echo "$network_stats"

echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< End of script  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
# Script ends here
