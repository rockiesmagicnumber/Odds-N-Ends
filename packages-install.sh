#!/usr/bin/env zsh
# Reinstalls everything captured by packages-export.sh. Run after
# repos-add-3rdparty.sh (so the apt-manual list's third-party packages
# have somewhere to come from) and before zshrc-setup.sh.
set -euo pipefail

REPO_DIR="${0:A:h}"
LISTS="$REPO_DIR/package-lists"

sudo apt update

# steam/discord/amdgpu-top/bottom/dbgate/tlrc/appimagelauncher get marked
# "manual" by apt-mark once installed via a local .deb (or, for
# steam-launcher, are obsolete and replaced by a metapackage apt can't
# resolve), so they show up in apt-manual.txt but aren't apt-installable by
# name - pull them out and handle them as direct .deb downloads instead.
MANUAL_DEB_PACKAGES=(steam steam-launcher discord amdgpu-top bottom dbgate tlrc appimagelauncher)
APT_PKGS=("${(@f)$(comm -23 <(sort "$LISTS/apt-manual.txt") <(printf '%s\n' "${MANUAL_DEB_PACKAGES[@]}" | sort))}")
sudo apt install -y "${APT_PKGS[@]}"

mkdir -p ~/Downloads
wget -qO ~/Downloads/steam_latest.deb https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb
wget -qO ~/Downloads/discord_latest.deb "https://discord.com/api/download?platform=linux&format=deb"
wget -qO ~/Downloads/amdgpu-top_latest.deb "$(curl -fsSL https://api.github.com/repos/Umio-Yasuno/amdgpu_top/releases/latest \
  | grep -oP '"browser_download_url":\s*"\K[^"]+/amdgpu-top_[0-9][^"]*_amd64\.deb')"
wget -qO ~/Downloads/bottom_latest.deb "$(curl -fsSL https://api.github.com/repos/ClementTsang/bottom/releases/latest \
  | grep -oP '"browser_download_url":\s*"\K[^"]+/bottom_[^"]+_amd64\.deb')"
wget -qO ~/Downloads/tlrc_latest.deb "$(curl -fsSL https://api.github.com/repos/tldr-pages/tlrc/releases/latest \
  | grep -oP '"browser_download_url":\s*"\K[^"]+x86_64-unknown-linux-gnu\.deb')"
wget -qO ~/Downloads/dbgate_latest.deb https://github.com/dbgate/dbgate/releases/latest/download/dbgate-latest.deb
# appimagelauncher's PPA is deprecated and never published for this distro's
# base (noble) - the GitHub release .deb is the only working source.
wget -qO ~/Downloads/appimagelauncher_latest.deb "$(curl -fsSL https://api.github.com/repos/TheAssassin/AppImageLauncher/releases/latest \
  | grep -oP '"browser_download_url":\s*"\K[^"]+appimagelauncher_[^"]+_amd64\.deb')"
sudo apt install -y ~/Downloads/steam_latest.deb ~/Downloads/discord_latest.deb ~/Downloads/amdgpu-top_latest.deb \
  ~/Downloads/bottom_latest.deb ~/Downloads/tlrc_latest.deb ~/Downloads/dbgate_latest.deb ~/Downloads/appimagelauncher_latest.deb

# Beeper Messenger ships Linux builds only as an AppImage, no .deb/apt repo.
# ~/Applications is the conventional spot appimagelauncher (installed above)
# looks in for integrating AppImages into the desktop menu.
mkdir -p ~/Applications
wget -qO ~/Applications/Beeper.AppImage https://api.beeper.com/desktop/download/linux/x64/stable/com.automattic.beeper.desktop
chmod +x ~/Applications/Beeper.AppImage

# flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub $(cat "$LISTS/flatpak-apps.txt")

# nvm (not apt-installable) + global npm packages
if [[ ! -d "$HOME/.nvm" ]]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh)"
fi
\. "$HOME/.nvm/nvm.sh"
nvm install --lts
while read -r pkg; do
  [[ -z "$pkg" ]] || npm install -g "$pkg"
done < "$LISTS/npm-global.txt"

# pip packages installed outside apt's control (see packages-export.sh for
# why this isn't a --user list). --break-system-packages matches how these
# got installed originally on this externally-managed system.
pip install --break-system-packages -r "$LISTS/pip-packages.txt"
