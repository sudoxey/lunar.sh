# GNOME Desktop Environment and System Configuration Script for Ubuntu 23.10 (Mantic Minotaur)

This script is designed to tweak various aspects of the GNOME desktop environment and perform system configuration on Ubuntu 23.10 (Mantic Minotaur). The script is divided into several sections, each serving a specific purpose. Before executing the script, it is important to review and understand each command to ensure compatibility and avoid unintended consequences.

## GNOME Desktop Tweak

The following `gsettings set` commands modify specific GNOME desktop settings:

- `org.gnome.desktop.interface`: These commands change the clock format, color scheme, GTK theme, and battery percentage display.

- `org.gnome.desktop.privacy`: These commands adjust privacy settings such as hiding the user's identity, removing old files, and disabling app and recent file usage tracking.

- `org.gnome.desktop.session`: This command sets the idle delay to 0, preventing the system from going idle.

- `org.gnome.mutter`: This command centers new windows on the screen.

- `org.gnome.nautilus.preferences`: These commands enable showing options for creating links and permanently deleting files in Nautilus.

- `org.gnome.settings-daemon.plugins.power`: These commands disable idle dimming and configure lid-close actions.

- `org.gnome.shell.extensions.dash-to-dock`: These commands modify the behavior of the Dash to Dock extension, such as the click and scroll actions, icon size, and visibility of mounted drives and trash.

- `org.gnome.shell.extensions.ding`: This command hides the "Home" button in the GNOME shell.

- `org.gnome.shell`: This command sets the favorite applications in the GNOME shell.

## Bash Configuration

The following commands modify the user's bash configuration:

- The `echo 'bind ...' >> $HOME/.bashrc` command adds a custom key binding to the user's `.bashrc` file, allowing them to clear command history and the screen using a specific key combination.

- The `echo "PATH=$PATH:$HOME/.local/bin" >> $HOME/.bashrc` command adds the local `bin` directory to the system's PATH variable, allowing the user to run executables stored in that directory.

## GTK Configuration

The following command adds a custom CSS rule to the GTK configuration file:

- The `echo 'VteTerminal, TerminalScreen, vte-terminal { ...' >> $HOME/.config/gtk-3.0/gtk.css` command modifies the appearance of terminal windows by adding padding and an inner border.

## Wallpaper Configuration

The script downloads a wallpaper image from a specified URL and sets it as the desktop background for both light and dark modes.

## GRUB Configuration

The script modifies the GRUB configuration by setting `GRUB_RECORDFAIL_TIMEOUT` to 0. This change disables the delay on boot after a failed boot.

## Package Management

The script performs package management tasks:

- It removes the Firefox snap package.

- It uninstalls specified packages using the `apt autoremove --purge` command, removing unnecessary software.

## Desktop Files Configuration

The script copies specific desktop files to the user's local applications directory and marks them as hidden.

## Repository Configuration

The script performs repository-related tasks:

- It imports the GPG key for Google Chrome and Visual Studio Code.

- It moves the GPG key to the trusted GPG directory.

- It adds the Google Chrome and Visual Studio Code repositories.

## System Upgrade and Driver Installation

The script updates the package lists and performs a full system upgrade using the `apt` package manager.

If an NVIDIA graphics card is detected, it installs the corresponding driver using the `nvidia-driver-525` package.

## Essential Package Installation

The script installs essential packages such as Visual Studio Code, Google Chrome, Git, and other specified packages using the `apt` package manager.

## Flatpak Configuration

The script performs Flatpak-related tasks:

- It adds the Flathub repository for Flatpak if it doesn't exist.

## Visual Studio Code Configuration

The script performs Visual Studio Code-related tasks:

- It installs the specified Visual Studio Code extension.

- It configures sysctl to increase the fs.inotify limit, allowing for better performance with file watchers.

- It creates a settings file for Visual Studio Code with specified preferences.

## System Cleanup

The script cleans up the system:

- It removes temporary files using the `apt clean` command.

- It cleans the package cache using the `apt autoclean` command.

- It removes unnecessary packages using the `apt autoremove --purge` command.

## System Reboot

Finally, the script initiates a system reboot using the `reboot` command.

*Disclaimer: Please note that it is important to understand each command's purpose and implications before executing the script. It is recommended to review and modify the script according to your specific needs and environment.*
