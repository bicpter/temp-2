#!/bin/bash

# Check if the wallet parameter is provided
if [ -z "$1" ]; then
    echo "You must provide the wallet's public key."
    echo "Usage: $0 <public_key>"
    exit 1
fi

# Wallet variable taken from the command line parameter
PUBLIC_KEY="$1"

# Path to the deb file
DEB_FILE="uam-latest_amd64.deb"

# URL to download the file
URL="https://update.u.is/downloads/uam/linux/$DEB_FILE"

# Function to install UAM
install_uam() {
    # Download the deb file
    wget $URL
    
    # Install the deb file
    sudo dpkg -i $DEB_FILE
}

# Function to run UAM
run_uam() {
    cd /opt/uam
    screen -dmS utopia ./uam --pk $PUBLIC_KEY
}

# Install UAM if needed
if [ ! -f /opt/uam/uam ]; then
    install_uam
fi

# Function to check if UAM is running and restart if necessary
check_and_run_uam() {
    while true; do
        # Check if UAM is running
        if ! screen -list | grep -q "utopia"; then
            echo "UAM is not running. Restarting..."
            run_uam
        else
            # If the UAM process is no longer running inside screen, exit the loop
            if ! ps -ef | grep -v grep | grep -q "/opt/uam/uam --pk $PUBLIC_KEY"; then
                echo "UAM has finished. Exiting script."
                exit 0
            fi
        fi
        # Sleep for 5 seconds before checking again
        sleep 5
    done
}

# Run the UAM process for the first time
run_uam

# Check and run UAM if it crashes
check_and_run_uam
