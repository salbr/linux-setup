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
ansible-galaxy collection install community.general

# Create the Ansible playbook
cat << EOF > install_packages.yml
---
- name: Install packages using package manager
  hosts: localhost
  become: yes
  vars:
    nvm_version: "0.40.1"
    node_version: "lts/*"
  tasks:
    - name: Install packages
      package:
        name:
          - krb5-workstation
          - jq
          - ansible-collection
          - ansible
          - fwupd
          - smartmontools
          - vainfo
          - virtualbox
          - chntpw
          - genisoimage
          - aria2
          - net-tools
          - VirtualBox-7.0
          - wireguard
          - wireguard-tools
          - google-chrome
          - libxdo
          - guake
          - git-lfs
          - codium
          - grub-customizer
          - openvpn
          - ffmpeg-libs
          - thunderbird
          - dnsmasq
          - firefox
          - keepassxc
          - flameshot
          - ripgrep
          - ufw
          - golang
          - shellcheck
        state: present

    - name: Install RPM Fusion free release (Fedora only)
      dnf:
        name: "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-{{ ansible_distribution_version }}.noarch.rpm"
        state: present
        disable_gpg_check: yes
      when: ansible_distribution == 'Fedora'

    - name: Install ffmpeg-libs (allowing erasing)
      package:
        name: ffmpeg-libs
        state: present
      vars:
        ansible_dnf_install_args: --allowerasing
      when: ansible_pkg_mgr == 'dnf'

    - name: Download NVM installation script
      get_url:
        url: "https://raw.githubusercontent.com/nvm-sh/nvm/v{{ nvm_version }}/install.sh"
        dest: /tmp/nvm_install.sh
        mode: '0755'
      become: no
    - name: Install NVM
      shell: /tmp/nvm_install.sh
      args:
        creates: "{{ ansible_env.HOME }}/.nvm/nvm.sh"
      become: no

    - name: Source NVM in .bashrc
      lineinfile:
        path: "{{ ansible_env.HOME }}/.bashrc"
        line: "[ -s '$HOME/.nvm/nvm.sh' ] && \\. '$HOME/.nvm/nvm.sh'"
        state: present
      become: no

    - name: Install latest LTS Node.js and npm
      shell: |
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        nvm install {{ node_version }}
        nvm use {{ node_version }}
      args:
        executable: /bin/bash
      become: no

    - name: Install global npm packages
      npm:
        name: "{{ item }}"
        global: yes
      loop:
        - "@bitwarden/cli"
        - "@angular/cli"
      become: no
      environment:
        PATH: "{{ ansible_env.HOME }}/.nvm/versions/node/{{ node_version }}/bin:{{ ansible_env.PATH }}"

EOF

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
    ansible-playbook install_packages.yml
    ;;
  n|N ) 
    echo "Playbook execution cancelled."
    ;;
  * ) 
    echo "Invalid input. Playbook execution cancelled."
    ;;
esac
