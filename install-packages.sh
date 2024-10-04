#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install packages using the appropriate package manager
install_package() {
    if command_exists dnf; then
        sudo dnf install -y "$1"
    elif command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y "$1"
    else
        echo "Error: Unsupported package manager. Please install $1 manually."
        exit 1
    fi
}

# Check and install Ansible if not present
if ! command_exists ansible; then
    echo "Ansible is not installed. Installing Ansible..."
    install_package ansible
else
    echo "Ansible is already installed."
fi

# Install Ansible Galaxy collection
echo "Installing Ansible Galaxy collection..."
ansible-galaxy collection install bitwarden.secrets
# Describe the play and ask for user confirmation
echo
echo "Ansible Playbook Description:"
echo "-----------------------------"
echo "This playbook will install various packages on your local system, including:"
echo "- Development tools and libraries"
echo "- System utilities (e.g., tlp, fwupd, net-tools)"
echo "- Applications (e.g., Visual Studio Code, VirtualBox, Firefox, Thunderbird)"
echo "- Programming languages and tools (e.g., Go, Node.js)"
echo
echo "It will use the appropriate package manager for your system (dnf or apt)."
echo "For Fedora systems, it will also install the RPM Fusion free release."
echo
read -p "Do you want to run this Ansible playbook? (y/n): " choice

case "$choice" in 
  y|Y ) 
    echo "Running Ansible playbook..."
    ansible-playbook -K install_packages.yml
    ;;
  n|N ) 
    echo "Playbook execution cancelled."
    ;;
  * ) 
    echo "Invalid input. Playbook execution cancelled."
    ;;
esac
