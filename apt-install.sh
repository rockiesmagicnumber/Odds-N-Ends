# utilities
sudo apt update
sudo apt install apt-transport-https curl wget

# brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# sublime text | merge
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# steam
wget -qO - https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb > ~/Downloads/steam_latest.deb

# discord
wget -qO - https://discord.com/api/download?platform=linux&format=deb > ~/Downloads/discord_latest.deb

# visual studio code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

# calibre
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

# pinta
# sudo snap install pinta
# flatpak install pinta

# install apt packages
sudo apt update
sudo apt install apt brave-browser sublime-text sublime-merge flatpak audacity dolphin gamehub lutris htop transmission timeshift fonts-powerline cheese clamav borgbackup code discord lgogdownloader pinta vlc
sudo apt install ~/Downloads/steam_latest.deb
sudo apt install ~/Downloads/amdgpu-top.deb
sudo apt install ~/Downloads/discord_latest.deb

# install flatpak packages
flatpak install flathub com.heroicgameslauncher.hgl

# oh-my-bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

### Update .bashrc

# # BEGIN lgogdownloader update library
# alias gog-library-refresh='lgogdownloader --download --platform w+l --directory /media/the-archive/Game-Installers/'
# # END

# # BEGIN update-and-something
# alias update-and-suspend='sudo apt update && sudo apt upgrade -y && flatpak upgrade -y && systemctl suspend'
# alias update-and-reboot='sudo apt update && sudo apt upgrade -y && flatpak upgrade -y && sudo reboot now'
# alias update-and-shutdown='sudo apt update && sudo apt upgrade -y && flatpak upgrade -y && sudo shutdown now'
# alias update-everything='sudo apt update && sudo apt upgrade -y && flatpak upgrade -y'
# alias gog-library-refresh='lgogdownloader --update-cache && lgogdownloader --repair --download --use-cache --check-orphans --platform w+l --directory /media/the-archive/Game-Installers/'
# # END 

# # BEGIN I always mix up the cmd/ps and bash "clear" commands.
# alias cls='clear'
# # END
