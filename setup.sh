#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check for sudo privileges
check_sudo() {
    if sudo -n true 2>/dev/null; then
        echo "Sudo privileges confirmed."
    else
        echo "This script requires sudo privileges for some operations."
        echo "You will be prompted for your password when necessary."
    fi
}

# Check for sudo privileges
check_sudo

# Check if Ansible is installed
if ! command_exists ansible; then
    echo "Ansible is not installed. Installing Ansible..."
    if command_exists dnf; then
        sudo dnf install -y ansible
    elif command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y ansible
    else
        echo "Error: Unsupported package manager. Please install Ansible manually."
        exit 1
    fi
else
    echo "Ansible is already installed."
fi

# Run the Ansible playbook
echo "Running Ansible playbook..."
sudo ./install_packages.sh

# Copy .bashrc and .inputrc
echo "Copying .bashrc and .inputrc..."
cp .bashrc ~/.bashrc
cp .inputrc ~/.inputrc

# Source .bashrc and .inputrc
echo "Sourcing .bashrc and .inputrc..."
source ~/.bashrc
bind -f ~/.inputrc

echo "Setup complete!"
echo "Please restart your terminal or run 'source ~/.bashrc' to ensure all changes are applied."
