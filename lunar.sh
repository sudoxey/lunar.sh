# Set the power profile to "performance" using powerprofilesctl
powerprofilesctl set performance

# Tweak various aspects of the GNOME desktop environment in the dconf settings database.
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
gsettings set org.gnome.shell favorite-apps '["org.gnome.Terminal.desktop", "org.gnome.Nautilus.desktop", "google-chrome.desktop", "code.desktop"]'

# Add a custom key binding for clearing history and screen in the user's bashrc file
echo 'bind '"'"'"\e[15~":"history -cw\C-mclear\C-m"'"'"'' >>$HOME/.bashrc

# Add local bin directory to the PATH in the user's bashrc file
echo "PATH=$PATH:$HOME/.local/bin" >>$HOME/.bashrc

# Add custom CSS rule to GTK configuration file
echo 'VteTerminal, TerminalScreen, vte-terminal { padding: 10px; -VteTerminal-inner-border: 10px; }' >>$HOME/.config/gtk-3.0/gtk.css

# Download a wallpaper image and set it as the desktop background
WALLPAPER="https://r4.wallpaperflare.com/wallpaper/384/818/513/himalayas-mountains-landscape-nature-wallpaper-6826fde8a0307cb8800cf11ed822d47a.jpg"
wget -qP $HOME/Pictures/Wallpapers "$WALLPAPER"
gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/Wallpapers/$(basename "$WALLPAPER")"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/Pictures/Wallpapers/$(basename "$WALLPAPER")"

# Set GRUB_RECORDFAIL_TIMEOUT to 0 and update GRUB configuration
echo "GRUB_RECORDFAIL_TIMEOUT=0" | sudo tee -a /etc/default/grub >/dev/null && sudo update-grub

# Remove Firefox snap package and uninstall specified packages
sudo snap remove firefox
sudo apt autoremove --purge -y apport eog gnome-calculator gnome-characters gnome-disk-utility gnome-font-viewer gnome-logs gnome-power-manager gnome-startup-applications gnome-system-monitor gnome-text-editor libevdocument3-4 seahorse ubuntu-report vim-common whoopsie yelp

# Copy desktop files to local applications directory and set them as hidden
cp '/usr/share/applications/gnome-language-selector.desktop' \
  '/usr/share/applications/nm-connection-editor.desktop' \
  '/var/lib/snapd/desktop/applications/snap-store_ubuntu-software.desktop' \
  '/usr/share/applications/software-properties-drivers.desktop' \
  "$HOME/.local/share/applications/"
for FILE in "$HOME/.local/share/applications/"*.desktop; do
  echo 'Hidden=true' >>"$FILE"
done

# Import Google Chrome GPG key, move it to the trusted GPG directory, and add the Google Chrome repository
wget -qO- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/google-chrome.gpg >/dev/null
sudo tee /etc/apt/sources.list.d/google-chrome.list >/dev/null <<<'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main'

# Import Microsoft GPG key, move it to trusted GPG directory, and add Visual Studio Code repository
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg >/dev/null
sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null <<<'deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main'

# Update package lists and perform a full system upgrade
sudo apt update && sudo apt full-upgrade -y

# Check if NVIDIA graphics card is detected and install the corresponding driver if found
if sudo lshw -C display 2>/dev/null | grep -q "NVIDIA"; then sudo apt install -y nvidia-driver-525; fi

# Install essential packages: Code, Curl, Flatpak, Git, GNOME Disk Utility, Flatpak plugin for GNOME Software, Google Chrome
sudo apt install -y code curl flatpak git gnome-disk-utility gnome-software-plugin-flatpak google-chrome-stable

# Add the Flathub repository for Flatpak if it doesn't exist already
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install VS Code extension, configure sysctl, create VS Code settings file
code --install-extension ms-vscode.live-server
sudo tee -a '/etc/sysctl.conf' >/dev/null <<<'fs.inotify.max_user_watches = 524288'
sudo sysctl -p >/dev/null
mkdir -p "$HOME/.config/Code/User"
tee "$HOME/.config/Code/User/settings.json" >/dev/null <<EOF
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
rm -rf .wget-hsts && sudo apt clean && sudo apt autoclean &>/dev/null && sudo apt autoremove --purge -y &>/dev/null

# Reboot the system
reboot
