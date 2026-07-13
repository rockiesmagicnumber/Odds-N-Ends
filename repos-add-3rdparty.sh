#!/usr/bin/env zsh
# Adds third-party APT repos/keys that a plain package-name list can't capture
# (Brave, Sublime Text/Merge, VSCodium, Calibre). Safe to re-run.
set -euo pipefail

# brave
if [[ ! -f /etc/apt/sources.list.d/brave-browser-release.list ]]; then
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
    https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
fi

# sublime text | merge
if [[ ! -f /etc/apt/sources.list.d/sublime-text.list ]]; then
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
fi

# vscodium
if [[ ! -f /etc/apt/sources.list.d/vscodium.list ]]; then
  wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main" \
    | sudo tee /etc/apt/sources.list.d/vscodium.list > /dev/null
fi

# calibre (upstream installer manages its own updates, no apt repo to add)
if ! command -v calibre >/dev/null 2>&1; then
  sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
fi

sudo apt update
