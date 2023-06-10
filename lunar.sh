#!/bin/bash

# Set the power profile to "performance" using powerprofilesctl
powerprofilesctl set performance

# Set the clock format to '12h'
gsettings set org.gnome.desktop.interface clock-format '12h'
# Set the color scheme to prefer dark
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
# Set the GTK theme to 'Yaru-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
# Show battery percentage in the top bar
# gsettings set org.gnome.desktop.interface show-battery-percentage 'true'
# Hide user identity information in system dialogs
gsettings set org.gnome.desktop.privacy hide-identity 'true'
# Set the duration for old files in the Recent files section to 0 days
gsettings set org.gnome.desktop.privacy old-files-age 'uint32 0'
# Set the maximum age for recent files to 1 day
gsettings set org.gnome.desktop.privacy recent-files-max-age '1'
# Disable remembering application usage
gsettings set org.gnome.desktop.privacy remember-app-usage 'false'
# Disable remembering recent files
gsettings set org.gnome.desktop.privacy remember-recent-files 'false'
# Automatically remove old temporary files
gsettings set org.gnome.desktop.privacy remove-old-temp-files 'true'
# Automatically remove old files from the trash
gsettings set org.gnome.desktop.privacy remove-old-trash-files 'true'
# Disable reporting technical problems
gsettings set org.gnome.desktop.privacy report-technical-problems 'false'
# Hide full name in the top bar
gsettings set org.gnome.desktop.privacy show-full-name-in-top-bar 'false'
# Set the idle delay to 0 (no idle timeout)
gsettings set org.gnome.desktop.session idle-delay '0'
# Center new windows when opened
gsettings set org.gnome.mutter center-new-windows 'true'
# Show the 'Create Link' option in Nautilus context menu
gsettings set org.gnome.nautilus.preferences show-create-link 'true'
# Show the 'Delete Permanently' option in Nautilus context menu
gsettings set org.gnome.nautilus.preferences show-delete-permanently 'true'
# Disable screen dimming when idle
gsettings set org.gnome.settings-daemon.plugins.power idle-dim 'false'
# Set the action when closing the lid while on AC power to 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'nothing'
# Set the action when closing the lid while on battery power to 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power lid-close-battery-action 'nothing'
# Set the click action for Dash-to-Dock to minimize
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
# Set the maximum icon size for Dash-to-Dock to 32 pixels
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size '32'
# Set the scroll action for Dash-to-Dock to cycle through windows
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
# Hide mounted drives from the Dash-to-Dock
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts 'false'
# Hide the Trash icon from the Dash-to-Dock
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash 'false'
# Hide the 'Show Applications' button in the top bar
gsettings set org.gnome.shell.extensions.ding show-home 'false'
# Set the favorite applications in the top bar
gsettings set org.gnome.shell favorite-apps '["org.gnome.Terminal.desktop", "org.gnome.Nautilus.desktop", "firefox_firefox.desktop", "code.desktop"]'

# Append the custom binding to clear history and clear the screen on F5 key press to the .bashrc file
echo 'bind "\"\e[15~":"history -cw\C-mclear\C-m\""' >> "$HOME/.bashrc"
# Append the specified path to the PATH variable in the .bashrc file
echo 'PATH=$PATH:$HOME/.local/bin' >> "$HOME/.bashrc"
# Reload the .bashrc file to apply the changes immediately
source "$HOME/.bashrc"

# Append custom CSS styles to the gtk.css file to adjust padding and inner border for terminals
echo 'VteTerminal, TerminalScreen, vte-terminal { padding: 10px; -VteTerminal-inner-border: 10px; }' >> "$HOME/.config/gtk-3.0/gtk.css"

# Download the image to the specified folder
wget -q -P "$HOME/Pictures/Wallpapers" "https://www.pixground.com/wp-content/uploads/2023/06/Moon-Purple-Japanese-Painting-AI-Generated-4K-Wallpaper.jpg"
# Set the downloaded image as the desktop background for the light mode
gsettings set org.gnome.desktop.background picture-uri "$HOME/Pictures/Wallpapers/$(basename "https://www.pixground.com/wp-content/uploads/2023/06/Moon-Purple-Japanese-Painting-AI-Generated-4K-Wallpaper.jpg")"
# Set the downloaded image as the desktop background for the dark mode
gsettings set org.gnome.desktop.background picture-uri-dark "$HOME/Pictures/Wallpapers/$(basename "https://www.pixground.com/wp-content/uploads/2023/06/Moon-Purple-Japanese-Painting-AI-Generated-4K-Wallpaper.jpg")"

# Set GRUB_RECORDFAIL_TIMEOUT to 0 in /etc/default/grub and update the GRUB configuration
# Note that changing this configuration may impact the ability to access alternate boot options, such as recovery mode or other operating systems, in case of a boot failure.
sudo sed -i 's/GRUB_RECORDFAIL_TIMEOUT=.*/GRUB_RECORDFAIL_TIMEOUT=0/' /etc/default/grub && sudo update-grub

# Remove specific GNOME-related packages and their configuration files.
sudo apt autoremove --purge -y apport eog gnome-calculator gnome-characters gnome-disk-utility gnome-font-viewer gnome-logs gnome-power-manager gnome-startup-applications gnome-system-monitor gnome-text-editor libevdocument3-4 seahorse ubuntu-report vim-common whoopsie yelp
# Remove Firefox Snap package
sudo snap remove firefox

# Copy specified desktop files and append "Hidden=true" to them
cp '/usr/share/applications/{im-config,gnome-language-selector,nm-connection-editor}.desktop' '/var/lib/snapd/desktop/applications/snap-store_ubuntu-software.desktop' '/usr/share/applications/software-properties-drivers.desktop' "$HOME/.local/share/applications" && tee -a "$HOME/.local/share/applications/{im-config,gnome-language-selector,nm-connection-editor,snap-store_ubuntu-software,software-properties-drivers}.desktop" <<< 'Hidden=true' > /dev/null

# Import Google Chrome GPG key, move it to the trusted GPG directory, and add the Google Chrome repository
wget -qO- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/google-chrome.gpg > /dev/null
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null

# Import Microsoft GPG key, move it to trusted GPG directory, and add Visual Studio Code repository
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null <<< 'deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main'

# Update package lists and perform a full system upgrade
sudo apt update && sudo apt full-upgrade -y

# Check if NVIDIA graphics card is detected and install the corresponding driver if found
if sudo lshw -C display 2>/dev/null | grep -q "NVIDIA"; then sudo apt install -y nvidia-driver; fi

# Install essential packages: Code, Curl, Flatpak, Git, GNOME Disk Utility, Flatpak plugin for GNOME Software, Google Chrome
sudo apt install -y code curl flatpak git gnome-disk-utility gnome-software-plugin-flatpak google-chrome-stable

# Add the Flathub repository for Flatpak if it doesn't exist already
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install File Roller, GNOME Calculator, and Eye of GNOME from Flathub
flatpak install flathub org.gnome.FileRoller org.gnome.Calculator org.gnome.EyeOfGnome

# Install VS Code extension, configure sysctl, create VS Code settings file
code --install-extension ms-vscode.live-server
sudo tee -a '/etc/sysctl.conf' > /dev/null <<< 'fs.inotify.max_user_watches = 524288'
sudo sysctl -p > /dev/null
mkdir -p "$HOME/.config/Code/User"
tee "$HOME/.config/Code/User/settings.json" > /dev/null << EOF
{
    "editor.acceptSuggestionOnEnter": "off",
    "editor.cursorBlinking": "phase",
    "editor.cursorWidth": 2,
    "editor.matchBrackets": "never",
    "editor.renderWhitespace": "all",
    "editor.smoothScrolling": true,
    "editor.wordBasedSuggestions": false,
    "explorer.confirmDelete": false,
    "explorer.confirmDragAndDrop": false,
    "extensions.closeExtensionDetailsOnViewChange": true,
    "extensions.ignoreRecommendations": true,
    "files.autoSave": "afterDelay",
    "files.enableTrash": false,
    "files.insertFinalNewline": true,
    "files.trimTrailingWhitespace": true,
    "git.enabled": false,
    "html.autoClosingTags": false,
    "html.format.indentInnerHtml": true,
    "livePreview.openPreviewTarget": "External Browser",
    "search.showLineNumbers": true,
    "security.workspace.trust.untrustedFiles": "open",
    "telemetry.telemetryLevel": "off",
    "terminal.integrated.cursorBlinking": true,
    "terminal.integrated.cursorStyle": "line",
    "terminal.integrated.cursorWidth": 2,
    "window.newWindowDimensions": "maximized",
    "window.titleBarStyle": "custom",
    "window.titleSeparator": " — ",
    "workbench.editor.scrollToSwitchTabs": true,
    "workbench.editor.untitled.hint": "hidden",
    "workbench.list.smoothScrolling": true,
    "workbench.startupEditor": "none"
}
EOF

# Clean package cache and remove unnecessary packages
rm -rf .wget-hsts && sudo apt clean && sudo apt autoclean &> /dev/null && sudo apt autoremove --purge -y &> /dev/null

# Reboot the system
reboot
