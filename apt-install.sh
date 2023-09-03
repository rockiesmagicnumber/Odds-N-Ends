# utilities
sudo apt update
sudo apt install apt-transport-https curl wget

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

# brave
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# sublime text | merge
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null

echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# steam
wget -qO - https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb > ~/Downloads/steam_latest.deb

# lutris
# echo "deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list > /dev/null
# wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg > /dev/null

# install apt packages
sudo apt update
sudo apt install nala brave-browser sublime-text sublime-merge flatpak audacity dolphin com.github.tkashkin.gamehub lutris htop python3 pipx transmission timeshift fonts-powerline cheese
sudo apt install ~/Downloads/steam_latest.deb
sudo apt install ~/Downloads/amdgpu-top.deb

# pip packages
pipx install lastversion

# lastversion installs
# amdgpu_top
lastversion --assets --filter amd64.deb download Umio-Yasuno/amdgpu_top -o amdgpu_top.deb
#wget -q0 - https://github.com/Umio-Yasuno/amdgpu_top/releases/download/v0.2.0/amdgpu-top_0.2.0_amd64.deb > ~/Downloads/amdgpu_top.deb

# calibre
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

# install flatpak packages
flatpak install flathub com.heroicgameslauncher.hgl

# oh-my-bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"


### Update .bashrc
# # BEGIN Stable-Diffusion aliasing
# alias stable-diffusion='sudo docker exec -it a1d7632f1603 bash'
# alias start-stable-diffusion='sudo docker start a1d7632f1603ecc93f6e0a088bcda62c34d91891fe2ddcd71d52788ea7348bea'
# # END Stable-Diffusion aliasing

# # BEGIN lgogdownloader update library
# alias gog-library-refresh='lgogdownloader --download --platform w+l --directory /media/the-archive/Game-Installers/'
# # END

# # BEGIN update-and-something
# alias update-and-suspend='sudo nala update && sudo nala upgrade -y && flatpak upgrade -y && systemctl suspend'
# alias update-and-reboot='sudo nala update && sudo nala upgrade -y && flatpak upgrade -y && sudo reboot now'
# alias update-and-shutdown='sudo nala update && sudo nala upgrade -y && flatpak upgrade -y && sudo shutdown now'
# alias update-everything='sudo nala update && sudo nala upgrade -y && flatpak upgrade -y'
# # END 

# # BEGIN export env variable for AGS SDK
# export LD_LIBRARY_PATH='~/arcgis/maps_sdk/qt200.0.0/sdk/linux/x64/lib'
# # END

# # BEGIN I always mix up the cmd/ps and bash "clear" commands.
# alias cls='clear'
# # END