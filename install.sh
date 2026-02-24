#!/bin/bash

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

if ! command -v pacman &>/dev/null; then
  echo -e "${RED}This script is for Arch-based systems only.${NC}"
  exit 1
fi

if [ -f /var/lib/pacman/db.lck ]; then
  echo -e "${RED}Pacman is currently locked. Finish the other transaction and try again.${NC}"
  exit 1
fi

sudo -v

echo -e "${BLUE}Starting TheIdioticdev's OXWM dotfile Dependency Installer for Arch-based systems...${NC}"
echo -e "${BLUE}Note: I use yay for this installer, make sure to have it (or edit this file to use paru instead) ${NC}"
PKGS=(
  "alacritty" "rofi" "flameshot" "xclip" "playerctl"
  "blueman" "thunar" "xwallpaper" "dunst" "network-manager-applet"
  "wireplumber" "xorg-setxkbmap" "gawk" "ttf-iosevka-nerd" "pipewire"
  "zig" "lua" "libx11" "libxft" "freetype2" "fontconfig" "libxinerama"
  "picom" "betterlockscreen" "oxwm-git" "brave-bin"
)

MISSING_PKGS=()

echo "Checking for installed dependencies..."

for pkg in "${PKGS[@]}"; do
  if pacman -Qq "$pkg" &>/dev/null; then
    echo "[✓] $pkg is already installed."
  else
    echo "[ ] $pkg is missing."
    MISSING_PKGS+=("$pkg")
  fi
done

if [ ${#MISSING_PKGS[@]} -eq 0 ]; then
  echo "Everything is already installed! You're good to go."
else
  echo "Installing missing dependencies: ${MISSING_PKGS[*]}"
  yay -S --needed "${MISSING_PKGS[@]}"
fi
