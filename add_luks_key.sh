#!/bin/bash

# Function to check if a drive is LUKS encrypted
is_luks_encrypted() {
    local device=$1
    cryptsetup isLuks "$device" &> /dev/null
    echo $?
}

# Function to generate a random passphrase
generate_passphrase() {
    local length=48
    tr -dc '0-9' </dev/urandom | head -c $length
}

# Get a list of all block devices
devices=$(lsblk -lnpo NAME,TYPE | awk '$2=="part" {print $1}')

# Сheck each device for the presence of a LUKS header
echo "Search for encrypted LUKS devices..."
luks_device_found=false
for device in $devices; do
    if [ $(is_luks_encrypted "$device") -eq 0 ]; then
        echo "Found LUKS device: $device"
        luks_device=$device
        luks_device_found=true
        break
    fi
done

# If the LUKS device is not found, complete the script execution
if [ "$luks_device_found" = false ]; then
    echo "No LUKS encrypted devices were found."
    exit 1
fi

# Get the current key for authorization
read -p "Enter the existing password for the LUKS device $luks_device: " -s existing_password
echo

# Generating a new passphrase
new_passphrase=$(generate_passphrase)

# Create a temporary file for the current mode
password_file=$(mktemp)
echo -n "$existing_password" > "$password_file"

# Adding a new slot to LUKS with a new passphrase
echo -n "$new_passphrase" | cryptsetup luksAddKey "$luks_device" --key-file="$password_file"
luks_add_result=$?

# Deleting a temporary file with a password
rm -f "$password_file"

# Checking the success of the operation
if [ $luks_add_result -eq 0 ]; then
    echo "New key added successfully."
    echo "New passphrase: $new_passphrase"

    # Save the new passphrase to a file on your desktop
    desktop_path="/home/$SUDO_USER/Desktop"
    passphrase_file="$desktop_path/luks_new_passphrase.txt"
    echo "$new_passphrase" > "$passphrase_file"

    # Checking the success of saving to a file
    if [ $? -eq 0 ]; then
        echo "The new passphrase is saved to a file: $passphrase_file"
    else
        echo "Error when saving passphrase to file."
    fi
else
    echo "Error adding a new key."
fi
