#!/bin/bash

# Prompt for source and destination paths
read -p "Enter the source path: " source
read -p "Enter the destination path: " destination

# Generate a timestamp for the backup
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

# Function to create a backup
function create_backup {
    # Define the backup directory
    backup_dir="$destination/backup_$timestamp"

    # Create a zip file of the source directory
    zip -r "$backup_dir.zip" "$source" > /dev/null

    # Check if the backup was successful
    if [ $? -eq 0 ]; then
        echo "Backup created successfully at $backup_dir.zip"
    else
        echo "Backup failed for $timestamp. Please check your source and destination paths."
    fi
}

# Function to handle backup rotation
function backup_rotation {
    # List all backup files sorted by modification time, with the most recent first
    backups=($(ls -t "$destination/backup_"*.zip))

    # Check if the number of backups exceeds the limit (e.g., 3)
    if [ "${#backups[@]}" -gt 3 ]; then
        # Select backups to remove (older ones)
        remove_backups=("${backups[@]:3}")
        for backup in "${remove_backups[@]}"; do
            rm "$backup"
            echo "Removed old backup: $backup"
        done
    fi
}

# Create a backup
create_backup

# Perform backup rotation
backup_rotation
