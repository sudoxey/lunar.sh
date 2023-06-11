# Introducing lunar.sh - Unleash the Power of Lunar Lobster! 🌕🦞

Are you ready to take your Ubuntu 23.04 LTS minimal installation to the next level? Look no further than lunar.sh, the ultimate bash script that will bring excitement and fun to your computing experience. Say goodbye to the mundane and hello to a lunar adventure like no other!

Here's how you can embark on this lunar escapade:

## Step 1: Prepare for Lunar Lobster

Start by downloading Ubuntu 23.04 (Lunar Lobster) from [the official website](https://ubuntu.com/download/desktop). But wait, don't settle for the ordinary! Opt for the minimal installation option to pave the way for the Lunar Lobster magic.

## Step 2: Unleash the Lunar Power

Now, it's time to run the script and unlock the true potential of Lunar Lobster. Simply open your terminal and enter the following command:

`wget https://github.com/sudoxey/lunar.sh/raw/main/lunar.sh -qO - | bash`

Watch as lunar.sh weaves its enchanting spells, automating tasks and infusing your Ubuntu with delightful surprises.

## Step 3: Embrace the Lunar Adventure

Prepare to be captivated by the wonders lunar Lobster has in store for you. From captivating desktop themes to exciting productivity tools, lunar.sh will transform your Ubuntu into a celestial playground.

But wait, there's more! We've sprinkled lunar.sh with a touch of moonlit magic, ensuring a smooth and enjoyable experience throughout your lunar adventure.

This script is designed to tweak various aspects of the GNOME desktop environment and perform system configuration on Ubuntu 23.04 (Lunar Lobster). The script is divided into several sections, each serving a specific purpose. Before executing the script, it is important to review and understand each command to ensure compatibility and avoid unintended consequences.

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

## License

lunar.sh is licensed under the [MIT License](https://github.com/sudoxey/lunar.sh/blob/main/LICENSE). Feel free to explore, modify, and share the script with fellow lunar explorers. Together, let's liberate the lunar world of computing!

So, what are you waiting for? Join the lunar Lobster revolution and embrace a computing experience that's out of this world. Get ready to be moonstruck with lunar.sh!

*Disclaimer: lunar.sh may cause an uncontrollable desire to explore the depths of the universe and inspire you to reach for the stars. Side effects may include increased productivity, enhanced creativity, and an insatiable appetite for lunar-themed snacks. Proceed with caution, and enjoy the Lunar Lobster adventure responsibly.*
