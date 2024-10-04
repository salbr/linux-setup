# Custom .bashrc Configuration

This README explains the modifications and additions made to the default .bashrc file. The custom .bashrc enhances your bash shell experience with improved history handling, colorized output, useful aliases, and more.

## Table of Contents

1. [History Control](#history-control)
2. [Prompt Customization](#prompt-customization)
3. [Color Support](#color-support)
4. [Aliases](#aliases)
5. [Path Modifications](#path-modifications)
6. [Persistent History](#persistent-history)
7. [Additional Configurations](#additional-configurations)

## History Control

- Ignores duplicate lines and lines starting with space in history:
  ```bash
  HISTCONTROL=ignoreboth
  ```
- Appends to history file instead of overwriting:
  ```bash
  shopt -s histappend
  ```
- Sets history size:
  ```bash
  HISTSIZE=1000
  HISTFILESIZE=2000
  ```

## Prompt Customization

- Introduces a customizable prompt with color support:
  ```bash
  PROMPT_ALTERNATIVE=twoline
  NEWLINE_BEFORE_PROMPT=yes
  ```
- Provides three prompt styles: twoline, oneline, and backtrack
- Uses different colors for root and regular users
- Includes virtualenv information in the prompt

## Color Support

- Enables color support for various commands:
  ```bash
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias diff='diff --color=auto'
  alias ip='ip --color=auto'
  ```
- Sets color codes for man pages

## Aliases

- Adds several useful aliases:
  ```bash
  alias ll='ls -l'
  alias la='ls -A'
  alias l='ls -CF'
  alias ls='ls -lisah --color=auto'
  ```
- Includes aliases for VSCodium with Wayland support:
  ```bash
  alias code=codium --enable-features=UseOzonePlatform --ozone-platform=wayland
  alias codium=codium --enable-features=UseOzonePlatform --ozone-platform=wayland
  ```

## Path Modifications

- Adds several custom directories to the PATH:
  ```bash
  export PATH=/home/siggi/dev/git/zgrab2:$PATH
  export PATH=/home/siggi/Downloads/owasp-dependency-checker/dependency-check/bin:$PATH
  export PATH=/home/siggi/dev/git/git-quick-stats:$PATH
  export PATH=$PATH:/usr/local/go/bin
  ```

## Persistent History

- Implements a function to log bash history persistently:
  ```bash
  log_bash_persistent_history()
  ```
- Adds an alias to grep through the persistent history:
  ```bash
  alias phgrep='cat ~/.persistent_history|grep --color'
  ```

## Additional Configurations

- Loads Angular CLI autocompletion
- Configures NVM (Node Version Manager)
- Sets up Bitwarden CLI app data directory

## Differences from Default .bashrc

1. The custom .bashrc is more extensive and feature-rich compared to the default.
2. It doesn't source global definitions from `/etc/bashrc`.
3. The PATH modification is more specific and includes additional directories.
4. It doesn't include the `.bashrc.d` directory sourcing logic.
5. Adds numerous features not present in the default, such as persistent history, color support, and custom aliases.

## Usage

To use this custom .bashrc:

1. Backup your existing .bashrc:
   ```
   cp ~/.bashrc ~/.bashrc.backup
   ```
2. Copy the custom .bashrc to your home directory:
   ```
   cp path/to/custom/.bashrc ~/.bashrc
   ```
3. Source the new .bashrc or restart your terminal:
   ```
   source ~/.bashrc
   ```

