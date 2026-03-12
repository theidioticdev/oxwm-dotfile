#!/bin/bash
set -e

# ─── Colors ───────────────────────────────────────────────────────────────────
WHITE='\033[1;37m'
GREY='\033[0;90m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# ─── Banner ───────────────────────────────────────────────────────────────────
print_banner() {
  echo -e "${WHITE}"
  echo '  ██████╗ ██╗  ██╗██╗    ██╗███╗   ███╗'
  echo ' ██╔═══██╗╚██╗██╔╝██║    ██║████╗ ████║'
  echo ' ██║   ██║ ╚███╔╝ ██║ █╗ ██║██╔████╔██║'
  echo ' ██║   ██║ ██╔██╗ ██║███╗██║██║╚██╔╝██║'
  echo ' ╚██████╔╝██╔╝ ██╗╚███╔███╔╝██║ ╚═╝ ██║'
  echo '  ╚═════╝ ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝     ╚═╝'
  echo -e "${GREY}  TheIdioticDev's OXWM dotfile installer — Arch only${NC}"
  echo -e "${GREY}  ─────────────────────────────────────────────────────${NC}\n"
}

# ─── UI Helper ────────────────────────────────────────────────────────────────
prompt_step() {
  echo -e -n "${WHITE}$(whoami)${NC} ${GREY}in${NC} ${WHITE}$(pwd | sed "s|^$HOME|~|")${NC} ${WHITE}→${NC} $1"
}

clear
print_banner

# ─── Arch only ────────────────────────────────────────────────────────────────
if ! command -v pacman &>/dev/null; then
  echo -e "${RED}✘ Error: This script is for Arch-based systems only.${NC}"
  exit 1
fi

# ─── Pacman lock check ────────────────────────────────────────────────────────
if [ -f /var/lib/pacman/db.lck ]; then
  echo -e "${RED}✘ Pacman is currently locked. Finish the other transaction first.${NC}"
  exit 1
fi

# ─── AUR helper check ─────────────────────────────────────────────────────────
AUR_HELPER=""
if command -v yay &>/dev/null; then
  AUR_HELPER="yay"
elif command -v paru &>/dev/null; then
  AUR_HELPER="paru"
else
  prompt_step "${YELLOW}No AUR helper found. Install yay now? (y/n): ${NC}"
  read -r install_aur
  if [[ "$install_aur" =~ ^([yY])$ ]]; then
    echo -e "\n${BLUE}Installing yay...${NC}"
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay_build
    cd /tmp/yay_build && makepkg -si --noconfirm && cd -
    rm -rf /tmp/yay_build
    AUR_HELPER="yay"
    echo -e "${GREEN}✔ yay installed.${NC}\n"
  else
    echo -e "${RED}✘ Cancelled. Install yay (https://github.com/Jguer/yay) or paru and try again.${NC}"
    exit 1
  fi
fi

sudo -v

echo -e "${BLUE}AUR Helper:${NC} $AUR_HELPER\n"

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
  "networkmanager"

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
echo -e "${GREY}Scanning dependencies...${NC}\n"

for pkg in "${PKGS[@]}"; do
  if pacman -Qq "$pkg" &>/dev/null; then
    echo -e "  ${GREEN}[✔]${NC} $pkg"
  else
    echo -e "  ${YELLOW}[ ]${NC} $pkg"
    MISSING_PKGS+=("$pkg")
  fi
done

echo ""

# ─── Already good? ────────────────────────────────────────────────────────────
if [ ${#MISSING_PKGS[@]} -eq 0 ]; then
  echo -e "${GREEN}✔ Everything is already installed. You're good to go.${NC}"
  exit 0
fi

# ─── Confirm & install ────────────────────────────────────────────────────────
echo -e "${BLUE}Missing:${NC} ${#MISSING_PKGS[@]} package(s): ${GREY}${MISSING_PKGS[*]}${NC}\n"

prompt_step "${WHITE}Proceed with installation? (y/n): ${NC}"
read -r confirm

if [[ "$confirm" =~ ^([yY])$ ]]; then
  echo -e "\n${BLUE}Starting sync...${NC}\n"
  $AUR_HELPER -S --needed "${MISSING_PKGS[@]}"
  echo -e "\n${GREEN}✔ All done! You can now run the rest of the setup.${NC}"
else
  echo -e "\n${RED}✘ Cancelled.${NC}"
  exit 0
fi
