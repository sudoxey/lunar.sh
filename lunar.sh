#!/bin/bash

powerprofilesctl set performance

wget 'https://i.redd.it/4lwyz6n35yma1.png' -P "$HOME/Pictures/Wallpapers"
gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/Wallpapers/4lwyz6n35yma1.png"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/Pictures/Wallpapers/4lwyz6n35yma1.png"

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
gsettings set org.gnome.nautilus.preferences show-create-link 'true'
gsettings set org.gnome.nautilus.preferences show-delete-permanently 'true'
gsettings set org.gnome.settings-daemon.plugins.power idle-dim 'false'
gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power lid-close-battery-action 'nothing'
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts 'false'
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash 'false'
gsettings set org.gnome.shell.extensions.ding show-home 'false'
gsettings set org.gnome.shell favorite-apps '["org.gnome.Terminal.desktop", "org.gnome.Nautilus.desktop", "firefox_firefox.desktop"]'

tee -a "$HOME/.bashrc" > /dev/null << EOF
bind '"\e[15~":"history -cw\C-mclear\C-m"'
PATH=$PATH:$HOME/.local/bin
EOF
source "$HOME/.bashrc"

tee -a "$HOME/.config/gtk-3.0/gtk.css" > /dev/null <<EOF
VteTerminal,
TerminalScreen,
vte-terminal {
    padding: 10px;
    -VteTerminal-inner-border: 10px;
}
EOF

sudo tee -a '/etc/default/grub' > /dev/null <<< 'GRUB_RECORDFAIL_TIMEOUT=0'
sudo update-grub

sudo apt autoremove --purge -y \
    apport \
    eog \
    gnome-calculator \
    gnome-characters \
    gnome-disk-utility \
    gnome-font-viewer \
    gnome-logs \
    gnome-power-manager \
    gnome-startup-applications \
    gnome-system-monitor \
    gnome-text-editor \
    libevdocument3-4 \
    seahorse \
    ubuntu-report \
    vim-common \
    whoopsie \
    yelp

cp \
    '/usr/share/applications/im-config.desktop' \
    '/usr/share/applications/gnome-language-selector.desktop' \
    '/usr/share/applications/nm-connection-editor.desktop' \
    '/var/lib/snapd/desktop/applications/snap-store_ubuntu-software.desktop' \
    '/usr/share/applications/software-properties-drivers.desktop' \
    "$HOME/.local/share/applications"
tee -a \
    "$HOME/.local/share/applications/im-config.desktop" \
    "$HOME/.local/share/applications/gnome-language-selector.desktop" \
    "$HOME/.local/share/applications/nm-connection-editor.desktop" \
    "$HOME/.local/share/applications/snap-store_ubuntu-software.desktop" \
    "$HOME/.local/share/applications/software-properties-drivers.desktop" \
    <<< 'Hidden=true' > /dev/null

sudo apt update
sudo apt full-upgrade -y

if [[ $(sudo lshw -C display 2> /dev/null | grep vendor) =~ NVIDIA ]];
   then
       sudo apt install -y nvidia-driver-525
fi

sudo apt install -y \
    curl \
    flatpak \
    git \
    gnome-software-plugin-flatpak

sudo snap install code --classic

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

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
    "workbench.startupEditor": "none",
}
EOF

rm -rf .wget-hsts
sudo apt clean
sudo apt autoclean &> /dev/null
sudo apt autoremove --purge -y &> /dev/null

reboot
