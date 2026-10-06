#!/bin/bash


current_user=$(whoami)
CONFIG_FILE="/home/$current_user/.script_settings/settings.txt"

echo "Reading configuration file for backup process..."


if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file not found at $CONFIG_FILE"
    echo "Please create a .script_settings directory in your home directory and add a settings.txt file with the necessary configuration."
    echo "Example configuration:"
    echo "  server_path = username@server_ip:/path/to/folderbackup"
    echo "  folders = [\"/path/to/folder1\", \"/path/to/folder2\", ...]"
    exit 1
fi

REMOTE_DEST=$(grep "server_path" "$CONFIG_FILE" | sed -e 's/ //g' -e 's/server_path=//')


if [ -z "$REMOTE_DEST" ]; then
    echo "Error: Could not find 'server_path' in configuration."
    exit 1
fi

echo "Target Destination: $REMOTE_DEST"


awk '
    /^folders[[:space:]]*=/ {
        in_folders = 1
        next
    }

    in_folders {
        if ($0 ~ /^\]/) {
            in_folders = 0
            exit
        }

        gsub(/^[[:space:]]*"/, "", $0)
        gsub(/",[[:space:]]*$/, "", $0)
        gsub(/"[[:space:]]*$/, "", $0)

        if ($0 != "") {
            print
        }
    }
' "$CONFIG_FILE" | while IFS= read -r path; do

    [ -z "$path" ] && continue

    echo "------------------------------------------------"
    echo "Found folder path to back up: $path"
    echo "Starting backup process for: $path"
    scp -r "$path" "$REMOTE_DEST"
    echo "Backup process completed for: $path"

done




