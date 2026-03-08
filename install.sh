#!/bin/bash
set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# ─── Arch only ────────────────────────────────────────────────────────────────
if ! command -v pacman &>/dev/null; then
  echo -e "${RED}This script is for Arch-based systems only.${NC}"
  exit 1
fi

# ─── Pacman lock check ────────────────────────────────────────────────────────
if [ -f /var/lib/pacman/db.lck ]; then
  echo -e "${RED}Pacman is currently locked. Finish the other transaction and try again.${NC}"
  exit 1
fi

# ─── AUR helper check ─────────────────────────────────────────────────────────
AUR_HELPER=""
if command -v yay &>/dev/null; then
  AUR_HELPER="yay"
elif command -v paru &>/dev/null; then
  AUR_HELPER="paru"
else
  echo -e "${RED}No AUR helper found (yay or paru). Please install one first.${NC}"
  echo -e "${YELLOW}Install yay: https://github.com/Jguer/yay${NC}"
  exit 1
fi

sudo -v

echo -e "${BLUE}Starting TheIdioticDev's OXWM dotfile installer for Arch-based systems...${NC}"
echo -e "${BLUE}Using AUR helper: ${AUR_HELPER}${NC}"

# ─── Packages ─────────────────────────────────────────────────────────────────
PKGS=(
  # WM + core
  "oxwm-git"

  # Terminal & shell eye candy
  "kitty"
  "figlet"
  "lolcat"
  "fastfetch"

  # Browser
  "brave-bin"

  # Launcher & screenshot
  "rofi"
  "flameshot"
  "xclip"

  # Media
  "playerctl"
  "pipewire"
  "pipewire-pulse"
  "wireplumber"
  "termusic"

  # Bluetooth & network
  "blueman"
  "network-manager-applet"

  # File manager
  "thunar"

  # Wallpaper & lockscreen
  "xwallpaper"
  "betterlockscreen"
  "xss-lock"

  # Notifications & compositor
  "dunst"
  "picom"

  # Keyboard & input utils
  "xorg-setxkbmap"
  "xdotool"

  # Fonts
  "ttf-iosevka-nerd"

  # Misc utils
  "gawk"
  "tmux"

  # Build deps (for oxwm-git)
  "zig"
  "lua"
  "libx11"
  "libxft"
  "freetype2"
  "fontconfig"
  "libxinerama"
)

# ─── Check what's missing ─────────────────────────────────────────────────────
MISSING_PKGS=()
echo ""
echo "Checking for installed dependencies..."
echo ""

for pkg in "${PKGS[@]}"; do
  if pacman -Qq "$pkg" &>/dev/null; then
    echo -e "${GREEN}[✓]${NC} $pkg"
  else
    echo -e "${YELLOW}[ ]${NC} $pkg is missing."
    MISSING_PKGS+=("$pkg")
  fi
done

echo ""

# ─── Install or exit ──────────────────────────────────────────────────────────
if [ ${#MISSING_PKGS[@]} -eq 0 ]; then
  echo -e "${GREEN}Everything is already installed! You're good to go.${NC}"
else
  echo -e "${BLUE}Installing ${#MISSING_PKGS[@]} missing package(s): ${MISSING_PKGS[*]}${NC}"
  echo ""
  $AUR_HELPER -S --needed "${MISSING_PKGS[@]}"
  echo ""
  echo -e "${GREEN}All done! You can now run the rest of the setup.${NC}"
fi
