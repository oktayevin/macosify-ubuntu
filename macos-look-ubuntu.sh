#!/bin/bash

# macOS Look for Ubuntu 24.04+ GNOME 46 Shell Setup
# Inspired by https://www.pling.com/p/2159316/

echo "Updating system and installing dependencies..."
sudo apt update && sudo apt install -y gnome-tweaks gnome-shell-extensions curl git plank wget unzip

# Install WhiteSur GTK Theme
echo "Installing WhiteSur GTK theme..."
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
./install.sh -m -l -N
cd ..
rm -rf WhiteSur-gtk-theme

# Install WhiteSur Icon Theme
echo "Installing WhiteSur Icon theme..."
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme
./install.sh -t all
cd ..
rm -rf WhiteSur-icon-theme

# Install San Francisco Font
echo "Installing macOS San Francisco font..."
mkdir -p ~/.fonts
cd ~/.fonts
wget -O SF-Pro.ttf https://github.com/sahibjotsaggu/San-Francisco-Font/raw/master/SF-Pro.ttf
cd ~

# Install Plank themes
echo "Installing Plank dock and macOS theme..."
mkdir -p ~/.config/plank/themes
cd ~/.config/plank/themes
wget -O macos-plank.zip https://github.com/i-mint/plank-themes/archive/refs/heads/main.zip
unzip macos-plank.zip
mv plank-themes-main/macOS ~/.config/plank/themes/macOS
rm -rf plank-themes-main macos-plank.zip
cd ~

# Set themes using gsettings
echo "Applying themes and fonts..."
gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-light"
gsettings set org.gnome.desktop.interface icon-theme "WhiteSur"
gsettings set org.gnome.desktop.interface font-name "SF Pro 11"

# Enable Plank on startup
echo "Adding Plank to startup..."
mkdir -p ~/.config/autostart
cat <<EOF > ~/.config/autostart/plank.desktop
[Desktop Entry]
Type=Application
Exec=plank
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Plank
EOF

# Set wallpaper
echo "Setting macOS Sequoia wallpaper..."
mkdir -p ~/Pictures/Sequoia-Wallpapers
cd ~/Pictures/Sequoia-Wallpapers
wget -O macos-sequoia.jpg https://images.macrumors.com/t/QZpAjHG2vE8f0pqPb9K5PLizq2I=/1600x0/article-new/2024/06/macos-sequoia-wallpaper.jpg
gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/Sequoia-Wallpapers/macos-sequoia.jpg"

# Done
echo "All done! Please restart your system or log out and back in to apply changes completely."
