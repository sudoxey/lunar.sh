powerprofilesctl set performance

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
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size '24'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts 'false'
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash 'false'
gsettings set org.gnome.shell.extensions.ding show-home 'false'
gsettings set org.gnome.shell favorite-apps '["org.gnome.Terminal.desktop", "org.gnome.Nautilus.desktop", "google-chrome.desktop", "code.desktop"]'

echo 'bind '"'"'"\e[15~":"history -cw\C-mclear\C-m"'"'"'' >>$HOME/.bashrc

WALLPAPER="https://i.redd.it/wphlh5f5xuc81.png"; wget -qP $HOME/Pictures/Wallpapers "$WALLPAPER" && gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/Wallpapers/$(basename "$WALLPAPER")" && gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/Pictures/Wallpapers/$(basename "$WALLPAPER")"

sudo apt autoremove --purge -y apport eog gnome-calculator gnome-characters gnome-font-viewer gnome-logs gnome-power-manager gnome-startup-applications gnome-system-monitor gnome-text-editor libevdocument3-4 seahorse ubuntu-report vim-common whoopsie yelp

sudo snap remove firefox

cp '/usr/share/applications/gnome-language-selector.desktop' '/usr/share/applications/nm-connection-editor.desktop' '/var/lib/snapd/desktop/applications/snap-store_ubuntu-software.desktop' '/usr/share/applications/software-properties-drivers.desktop' "$HOME/.local/share/applications/" && for FILE in "$HOME/.local/share/applications/"*.desktop; do echo 'Hidden=true' >>"$FILE"; done

wget -qO- https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor --output /etc/apt/trusted.gpg.d/google.gpg && sudo tee /etc/apt/sources.list.d/google-chrome.list >/dev/null <<<'deb [signed-by=/etc/apt/trusted.gpg.d/google.gpg] http://dl.google.com/linux/chrome/deb/ stable main'
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --output /etc/apt/trusted.gpg.d/microsoft.gpg && sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null <<<'deb [signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main'

sudo apt update && sudo apt full-upgrade -y

if sudo lshw -C display 2>/dev/null | grep -q "NVIDIA"; then sudo apt install -y nvidia-driver-535; fi

sudo apt install -y code flatpak gnome-software-plugin-flatpak google-chrome-stable python3-venv

sudo flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo

code --install-extension ms-vscode.live-server && sudo tee -a '/etc/sysctl.conf' >/dev/null <<<'fs.inotify.max_user_watches = 524288' && sudo sysctl -p >/dev/null && mkdir -p "$HOME/.config/Code/User"
tee "$HOME/.config/Code/User/settings.json" >/dev/null <<EOF
{
  "editor.acceptSuggestionOnEnter": "off",
  "editor.matchBrackets": "never",
  "editor.renderWhitespace": "all",
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
  "html.format.indentInnerHtml": true,
  "livePreview.notifyOnOpenLooseFile": false,
  "search.showLineNumbers": true,
  "security.workspace.trust.untrustedFiles": "open",
  "telemetry.telemetryLevel": "off",
  "terminal.integrated.cursorBlinking": true,
  "window.newWindowDimensions": "maximized",
  "window.titleBarStyle": "custom",
  "window.titleSeparator": " — ",
  "workbench.editor.scrollToSwitchTabs": true,
  "workbench.editor.untitled.hint": "hidden",
  "workbench.startupEditor": "none"
}
EOF

rm -rf .wget-hsts && sudo apt clean && sudo apt autoclean &>/dev/null && sudo apt autoremove --purge -y &>/dev/null

reboot
