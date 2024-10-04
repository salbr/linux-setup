# Custom .inputrc Configuration

This document explains the custom `.inputrc` configuration file. The `.inputrc` file is used to customize the behavior of GNU Readline, which is used by Bash and many other command-line programs for input editing and history navigation.

## Contents

```
"\e[5~": history-search-backward
"\e[6~": history-search-forward
set show-all-if-ambiguous on
set completion-ignore-case on
```

## Explanation

1. **History Search Bindings**
   ```
   "\e[5~": history-search-backward
   "\e[6~": history-search-forward
   ```
   - These lines bind the Page Up (`\e[5~`) and Page Down (`\e[6~`) keys to history search functions.
   - Pressing Page Up will search backward through your command history, matching the current input.
   - Pressing Page Down will search forward through your command history, matching the current input.
   - This allows for quick and easy navigation through your command history based on what you've already typed.

2. **Show All Completions if Ambiguous**
   ```
   set show-all-if-ambiguous on
   ```
   - This setting enables the display of all possible completions immediately, without requiring a second Tab press.
   - When there are multiple completion possibilities, they will be shown right away after pressing Tab once.
   - This can speed up command completion and exploration of available options.

3. **Case-Insensitive Completion**
   ```
   set completion-ignore-case on
   ```
   - This setting makes command-line completion case-insensitive.
   - For example, typing `CD` and pressing Tab will complete to `cd` if it's the only matching command.
   - This can make completion more convenient, especially if you're not always consistent with capitalization.

## Usage

To use this custom `.inputrc` configuration:

1. Create or edit the `.inputrc` file in your home directory:
   ```
   nano ~/.inputrc
   ```

2. Copy and paste the contents into this file.

3. Save the file and exit the editor.

4. For the changes to take effect, you'll need to restart your terminal or reload the `.inputrc` file:
   ```
   bind -f ~/.inputrc
   ```

