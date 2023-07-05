# Set the power profile to "performance" using powerprofilesctl
powerprofilesctl set performance

# Tweak various aspects of the GNOME desktop environment in the dconf settings database
gsettings set org.gnome.desktop.interface clock-format '12h'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
gsettings set org.gnome.desktop.interface show-battery-percentage 'true'
gsettings set org.gnome.desktop.privacy hide-identity 'true'
gsettings set org.gnome.desktop.privacy old-files-age 'uint32 0'
gsettings set org.gnome.desktop.privacy recent-files-max-age '1'
gsettings set org.gnome.desktop.privacy remember-app-usage 'false'
gsettings set org.gnome.desktop.privacy remember-recent-files 'false'
gsettings set org.gnome.desktop.privacy remove-old-temp-files 'true'
gsettings set org.gnome.desktop.privacy remove-old-trash-files 'true'
gsettings set org.gnome.desktop.privacy report-technical-problems 'false'
gsettings set org.gnome.desktop.privacy show-full-name-in-top-bar 'false'
gsettings set org.gnome.desktop.session idle-delay '0'
gsettings set org.gnome.mutter center-new-windows 'true'
gsettings set org.gnome.nautilus.preferences show-create-link 'true'
gsettings set org.gnome.nautilus.preferences show-delete-permanently 'true'
gsettings set org.gnome.settings-daemon.plugins.power idle-dim 'false'
gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power lid-close-battery-action 'nothing'
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size '32'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts 'false'
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash 'false'
gsettings set org.gnome.shell.extensions.ding show-home 'false'
gsettings set org.gnome.shell favorite-apps '["org.gnome.Terminal.desktop", "org.gnome.Nautilus.desktop", "firefox_firefox.desktop", "code.desktop"]'

# Add a custom F5 key binding for clearing history and screen in the user's bashrc file
echo 'bind '"'"'"\e[15~":"history -cw\C-mclear\C-m"'"'"'' >>$HOME/.bashrc

# Download a wallpaper image and set it as the desktop background
WALLPAPER="https://i.redd.it/wphlh5f5xuc81.png"; wget -qP $HOME/Pictures/Wallpapers "$WALLPAPER" && gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/Wallpapers/$(basename "$WALLPAPER")" && gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/Pictures/Wallpapers/$(basename "$WALLPAPER")"

# Set GRUB_RECORDFAIL_TIMEOUT to 0 and update GRUB configuration
echo "GRUB_RECORDFAIL_TIMEOUT=0" | sudo tee -a /etc/default/grub >/dev/null && sudo update-grub

# Remove and uninstall specified packages
sudo apt autoremove --purge -y apport eog gnome-calculator gnome-characters gnome-font-viewer gnome-logs gnome-power-manager gnome-startup-applications gnome-system-monitor gnome-text-editor libevdocument3-4 seahorse ubuntu-report vim-common whoopsie yelp

# Copy desktop files to local applications directory and set them as hidden
cp '/usr/share/applications/gnome-language-selector.desktop' '/usr/share/applications/nm-connection-editor.desktop' '/var/lib/snapd/desktop/applications/snap-store_ubuntu-software.desktop' '/usr/share/applications/software-properties-drivers.desktop' "$HOME/.local/share/applications/" && for FILE in "$HOME/.local/share/applications/"*.desktop; do echo 'Hidden=true' >>"$FILE"; done

# Import Microsoft GPG key, move it to trusted GPG directory, and add Visual Studio Code repository
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg >/dev/null && sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null <<<'deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main'

# Update package lists and perform a full system upgrade
sudo apt update && sudo apt full-upgrade -y

# Check if NVIDIA graphics card is detected and install the corresponding driver if found
if sudo lshw -C display 2>/dev/null | grep -q "NVIDIA"; then sudo apt install -y nvidia-driver-535; fi

# Install essential packages: Node.js, Code, Flatpak, and Flatpak plugin for GNOME Software
sudo snap install node --channel=20/stable --classic && sudo apt install -y code flatpak gnome-software-plugin-flatpak

# Add the Flathub repository for Flatpak
sudo flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo

# Install VS Code extension, configure sysctl, and create VS Code settings file
code --install-extension ms-vscode.live-server && sudo tee -a '/etc/sysctl.conf' >/dev/null <<<'fs.inotify.max_user_watches = 524288' && sudo sysctl -p >/dev/null && mkdir -p "$HOME/.config/Code/User"
tee "$HOME/.config/Code/User/settings.json" >/dev/null <<EOF
{
  "editor.acceptSuggestionOnEnter": "off",
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 0,
  "files.insertFinalNewline": true,
  "files.trimTrailingWhitespace": true,
  "livePreview.notifyOnOpenLooseFile": false,
  "security.workspace.trust.untrustedFiles": "open",
  "telemetry.telemetryLevel": "off",
  "terminal.integrated.cursorBlinking": true,
  "window.titleBarStyle": "custom",
  "workbench.editor.untitled.hint": "hidden",
  "workbench.startupEditor": "none"
}
EOF

# Clean package cache and remove unnecessary packages
rm -rf .wget-hsts && sudo apt clean && sudo apt autoclean &>/dev/null && sudo apt autoremove --purge -y &>/dev/null

# Reboot the system
reboot
