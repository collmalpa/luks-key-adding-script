# LUKS Key Adding Script

This repository contains a Bash script designed to automate adding a LUKS key to encrypted drives. The script performs the following functions:

1. **Automatically Identifies LUKS-Encrypted Disks:** Scans all block devices on the system to find LUKS-encrypted partitions.
2. **Generates a Random Passphrase:** Creates a secure, random passphrase consisting of 48 numeric characters.
3. **Adds a New Key Slot to the LUKS Device:** Utilizes the existing LUKS passphrase to add the newly generated passphrase to a new key slot.
4. **Saves the New Passphrase:** Stores the newly generated passphrase in a text file on the user's desktop for future reference.

## Features

- **Automatic Detection:** Automatically finds LUKS-encrypted devices, removing the need for manual input.
- **Secure Passphrase Generation:** Generates a highly secure passphrase to ensure data protection.
- **User-Friendly:** Prompts the user for necessary information and provides clear feedback throughout the process.
- **Convenient Storage:** Saves the new passphrase to a file on the desktop, ensuring it is easily accessible.

## Usage

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/collmalpa/luks-key-management-script.git
   cd luks-key-management-script
   ```

2. **Make the Script Executable:**
   ```bash
   chmod +x add_luks_key.sh
   ```

3. **Run the Script with Superuser Privileges:**
   ```bash
   sudo ./add_luks_key.sh
   ```

4. **Follow the Prompts:** Enter the existing LUKS passphrase when prompted. The script will handle the rest, including detecting the LUKS device, generating a new passphrase, adding the new key slot, and saving the passphrase to a file on your desktop.

## Example Output

```plaintext
Search for encrypted LUKS devices...
Found LUKS device: /dev/sdX1
Enter the existing password for the LUKS device /dev/sdX1:
New key added successfully.
New passphrase: 123847123570687390847834072346234689672067923842
The new passphrase is saved to a file: /home/user/Desktop/luks_new_passphrase.txt
```

## Requirements

- **Bash:** The script is written in Bash and should be run in a Unix-like environment.
- **cryptsetup:** Ensure `cryptsetup` is installed on your system for managing LUKS devices.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.
