#!/bin/bash

# macOS Sequoia görünümü için tam otomatik Ubuntu yapılandırma betiği

# Gerekli paketleri kur
sudo apt update && sudo apt install -y gnome-tweaks gnome-shell-extensions curl git plank ulauncher dconf-cli wget unzip

# WhiteSur GTK tema kurulumu
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
./install.sh -m -l -N
cd ..
rm -rf WhiteSur-gtk-theme

# WhiteSur ikon tema kurulumu
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme
./install.sh -t all
cd ..
rm -rf WhiteSur-icon-theme

# San Francisco font kurulumu
mkdir -p ~/.fonts
cd ~/.fonts
wget -O SF-Pro.ttf https://github.com/sahibjotsaggu/San-Francisco-Font/raw/master/SF-Pro.ttf
cd ~

# Plank teması kurulumu
mkdir -p ~/.config/plank/themes
cd ~/.config/plank/themes
wget -O macos-plank.zip https://github.com/i-mint/plank-themes/archive/refs/heads/main.zip
unzip macos-plank.zip
mv plank-themes-main/macOS ~/.config/plank/themes/macOS
rm -rf plank-themes-main macos-plank.zip
cd ~

# GRUB teması kurulumu
git clone https://github.com/vinceliuice/WhiteSur-grub-theme.git
cd WhiteSur-grub-theme
sudo ./install.sh -b -t black
cd ..
rm -rf WhiteSur-grub-theme

# GNOME tema ayarları
gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-light"
gsettings set org.gnome.desktop.interface icon-theme "WhiteSur"
gsettings set org.gnome.desktop.interface font-name "SF Pro 11"

# Plank'i başlangıca ekle
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

# Ulauncher kısayol bilgisi (manuel ayarlanmalı)

# Duvar kağıdı kurulumu
mkdir -p ~/Pictures/Sequoia-Wallpapers
cd ~/Pictures/Sequoia-Wallpapers
wget https://images.macrumors.com/t/QZpAjHG2vE8f0pqPb9K5PLizq2I=/1600x0/article-new/2024/06/macos-sequoia-wallpaper.jpg
gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/Sequoia-Wallpapers/macos-sequoia-wallpaper.jpg"
cd ~

# Auto Theme (gün doğumu/batımı light/dark geçiş)
git clone https://github.com/tkashkin/auto-gtk-theme.git
cd auto-gtk-theme
./install.sh
~/.local/bin/auto-gtk-theme setup --lat 41.0082 --lon 28.9784 --theme-light WhiteSur-light --theme-dark WhiteSur-dark
cd ..
rm -rf auto-gtk-theme

echo "Kurulum tamamlandı! Sistemi yeniden başlatmanı öneririm."
