# System Setup Repository

This repository contains scripts and configuration files to set up a development environment quickly and efficiently. It includes an Ansible playbook for installing packages and a custom .bashrc file for shell configuration.

## Contents

1. [Ansible Playbook](#ansible-playbook)
2. [Bash Configuration](#bash-configuration)
3. [Usage](#usage)
4. [Customization](#customization)

## Ansible Playbook

The `setup_and_run_ansible.sh` script installs Ansible and runs a playbook to set up your system. It performs the following tasks:

- Installs Ansible if not already present
- Installs the Ansible Galaxy collection
- Creates and runs a playbook that installs various packages, including:
  - Development tools and libraries
  - System utilities (e.g., tlp, fwupd, net-tools)
  - Applications (e.g., Visual Studio Code, VirtualBox, Firefox, Thunderbird)
  - Programming languages and tools (e.g., Go, Node.js)

The script is designed to work on both Fedora (using DNF) and Debian-based systems (using APT).

## Bash Configuration

The repository includes a custom `.bashrc` file with various useful configurations and aliases:

- Customized prompt with color support
- History settings for better command tracking
- Color support for various commands (ls, grep, etc.)
- Useful aliases for common commands
- PATH modifications for custom tools
- Persistent bash history logging
- NVM (Node Version Manager) configuration
- Angular CLI autocompletion

## Usage

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/system-setup.git
   cd system-setup
   ```

2. Run the Ansible setup script:
   ```
   chmod +x setup_and_run_ansible.sh
   ./setup_and_run_ansible.sh
   ```

3. Copy the `.bashrc` file to your home directory:
   ```
   cp .bashrc ~/.bashrc
   ```

4. Restart your terminal or run `source ~/.bashrc` to apply the new bash configuration.

## Customization

### Ansible Playbook

You can customize the list of packages to be installed by modifying the `install_packages.yml` file within the `setup_and_run_ansible.sh` script. Add or remove packages as needed for your specific setup.

### Bash Configuration

The `.bashrc` file can be customized to suit your preferences:

- Modify the `PROMPT_ALTERNATIVE` variable to change the prompt style (options: twoline, oneline, backtrack)
- Add or modify aliases in the "Alias definitions" section
- Adjust PATH modifications to include your own custom directories
- Modify the persistent history logging function if needed

Remember to source the `.bashrc` file or restart your terminal after making changes.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
