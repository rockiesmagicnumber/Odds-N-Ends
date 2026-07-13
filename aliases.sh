# Sourced from ~/.zshrc by zshrc-setup.sh. Edit here, not in .zshrc directly,
# so changes are versioned and survive a wipe automatically once this repo
# is re-cloned.

alias borg-backup="$HOME/Repos/Odds-N-Ends/borg-backup.sh"
# Fixed from the old .bashrc block: was `apt update || borg-backup || apt
# full-upgrade ...`, which only ran the backup if `apt update` FAILED, and
# only ran the upgrade if both prior steps failed. Should be a straight
# sequence: update, then back up, then upgrade.
alias update-everything='sudo apt update && borg-backup && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && flatpak update -y'
alias update-and-suspend='update-everything && systemctl suspend'
alias update-and-reboot='update-everything && sudo reboot now'
# Fixed typo: was `supdate-everything`.
alias update-and-shutdown='update-everything && sudo shutdown now'
alias gog-library-refresh='lgogdownloader --update-cache && lgogdownloader --repair --download --use-cache --check-orphans --platform w+l --directory /mnt/network-storage/Game-Installers/'

export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$HOME/platform-tools:$PATH"
