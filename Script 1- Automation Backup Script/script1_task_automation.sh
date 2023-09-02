#!/bin/bash

# Script: script1_task_automation.sh
# Purpose: To automate backups of a specified source directory to a destination directory at regular intervals (every 10 seconds) while logging the results.
# Author: Rahul Nagaraju
# Date: August 31, 2023

# Define the log file where results will be recorded
log_file="automation_results.txt"

echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Starting Backup Automation Script >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" | tee -a "$log_file"

# Function for displaying and recording messages
log_message() {
    local message="$1"
    echo "$message"
    echo "$message" >> "$log_file"
}

# Set the source and destination directories below:
source_directory="/home/rahul/Assignment1"
destination_directory="/home/rahul/Assignment1_Backup"

while true; do
    # Check if the source directory exists
    if [ ! -d "$source_directory" ]; then
        log_message "Error: The source directory '$source_directory' does not exist."
    else
        log_message "Initiating the backup process..."

        # Generate a timestamp in the format YYYYMMDD-HHMMSS for the backup folder
        timestamp=$(date +"%Y%m%d-%H%M%S")

        log_message "Creating a backup folder with the timestamp: $timestamp"

        # Establish a backup folder within the destination directory using the timestamp
        backup_folder="$destination_directory/backup-$timestamp"

        # Ensure the destination directory exists; create it if it doesn't
        if [ ! -d "$destination_directory" ]; then
            log_message "The destination directory '$destination_directory' does not exist. It will be created..."
            mkdir -p "$destination_directory"
        fi

        # Employ rsync, a robust file synchronization tool, for the backup
        rsync -av "$source_directory" "$backup_folder"

        # Examine the exit status of rsync to confirm the success of the backup
        if [ $? -eq 0 ]; then
            log_message "Backup completed successfully. Files are now stored in '$backup_folder'."
        else
            log_message "Backup failed. Please review the source and destination directories."
        fi

        # Log the details of the backup operation in a file named 'backup.log'
        echo "Backup of '$source_directory' to '$backup_folder' executed at $(date)" >> backup.log

        log_message "The backup process has concluded. Results are recorded in '$log_file'."
    fi

    # Pause for 10 seconds before repeating the script
    sleep 10
done

# End of Script

