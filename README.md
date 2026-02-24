# OXWM Dotfile


My personal OXWM + fastfetch configs, feel free to try it out!

![Screenshot](screenshot.png)
![Screenshot](floatingwindows.png)

## What is OXWM?

OXWM is a dynamic window manager written in Zig, inspired by dwm but with modern improvements:
- Lua configuration with hot-reload (no recompiling!)
- LSP support for config autocomplete
- Keychord support for advanced keybindings
- Built-in status bar
- Multi-monitor support

Check out the [official repo](https://github.com/tonybanters/oxwm) for more info.

## My Setup (for reference)

- **OS**: CachyOS
- **Terminal**: Alacritty
- **Launcher**: Rofi
- **Browser**: Brave
- **Font**: Iosevka Mono Nerd Font
- **Themes included**: Catppuccin Mocha, Gruvbox, Tokyo Night, Nord, Oxocarbon

## Features

- **Status bar** with kernel info, RAM usage, battery, volume, keyboard layout, and date/time
- **Workspace tags** using nerd font icons instead of numbers
- **Keychords** for advanced keybinds (Mod+Space + key combos)
- **Window rules** for auto-tagging apps to specific workspaces
- **Dual keyboard layout** (US/Arabic) with Alt+Shift toggle
- **Media controls** for PipeWire/WirePlumber
- **Modular config** with separate color scheme file

## Installation

### Dependencies

```bash
# Installing OXWM on Arch-based distros (NixOS tutorial in OXWM's official repo, any other distro can compile it from source)
yay -S oxwm-git

# Dependencies installer
./install.sh 

OR (if you do not want to run scripts)
# replace yay with paru if you want
yay -S alacritty brave-bin rofi flameshot xclip playerctl blueman thunar \
xwallpaper dunst network-manager-applet wireplumber xorg-setxkbmap gawk ttf-iosevka-nerd \
zig lua libx11 libxft freetype2 fontconfig libxinerama
```

```bash
# ─── Debian-based (Ubuntu, Mint, etc.) ───────────────────────────────────────

# Add Brave repo first (it's not in apt by default)
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
  https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] \
  https://brave-browser-apt-release.s3.brave.com/ stable main" \
  | sudo tee /etc/apt/sources.list.d/brave-browser.list
sudo apt update

# Install dependencies
sudo apt install -y alacritty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst network-manager-gnome wireplumber gawk \
  fonts-iosevka-nerd zig lua5.4 libx11-dev libxft-dev libfreetype6-dev \
  libfontconfig1-dev libxinerama-dev

# Note: fonts-iosevka-nerd may not be available on older Debian/Ubuntu releases.
# If it's not found, grab the Iosevka Nerd Font manually:
# https://github.com/ryanoasis/nerd-fonts/releases (download IosevkaTerm.zip)
# Then: mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv

# Zig is not in Debian repos, install it manually (if you use snaps):
sudo snap install zig --classic --beta

# OR grab it directly from ziglang.org (more control over version):
wget https://ziglang.org/download/0.15.2/zig-linux-x86_64-0.15.2.tar.xz
tar -xf zig-linux-x86_64-0.15.2.tar.xz
sudo mv zig-linux-x86_64-0.15.2 /opt/zig
echo 'export PATH=$PATH:/opt/zig' >> ~/.bashrc
source ~/.bashrc
```

```bash
# ─── Fedora / RHEL-based (Fedora, Rocky, Alma, etc.) ─────────────────────────

# Add Brave repo first
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo \
  https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# Install dependencies
sudo dnf install -y alacritty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst NetworkManager-tui wireplumber gawk \
  zig lua libX11-devel libXft-devel freetype-devel \
  fontconfig-devel libXinerama-devel

# Grab Iosevka Nerd Font manually (not in Fedora repos):
# https://github.com/ryanoasis/nerd-fonts/releases (download IosevkaTerm.zip)
# Then: mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv

# Note: alacritty may need cargo/rust if not in your Fedora version's repos.
# Fallback: sudo dnf install -y cargo && cargo install alacritty
```

```bash
# ─── OpenSUSE Tumbleweed ──────────────────────────────────────────────────────

# Add Brave repo first
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo zypper addrepo \
  https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo zypper refresh

# Install dependencies
sudo zypper install -y alacritty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst NetworkManager network-manager-applet \
  wireplumber gawk zig lua54 libX11-devel libXft-devel freetype2-devel \
  fontconfig-devel libXinerama-devel

# Grab Iosevka Nerd Font manually (package name is inconsistent across repos):
# https://github.com/ryanoasis/nerd-fonts/releases (download IosevkaTerm.zip)
# Then: mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv
```

### Installing the Config

```bash
# Clone this repo
git clone https://github.com/theidioticdev/oxwm-dotfile
cd oxwm-dotfile

# Backup existing config if you have one
mv ~/.config/oxwm /path/to/backup  # replace this with an actual directory
mv ~/.config/fastfetch/config.jsonc /path/to/backup  # replace this with an actual directory

# Copy config
cp -r ./oxwm ~/.config/
cp -r ./fastfetch ~/.config

# Copy wallpaper (adjust path as needed)
mkdir -p ~/dotfiles/  
cp -r ./walls ~/dotfiles/

# Before the next step, I recommend editing wallmenu so you can tweak the wallpaper directories
sudo cp powermenu /usr/local/bin
sudo cp wallmenu /usr/local/bin/

# you do not need to use my wallpapers, if you have your set of walls, you can use them too
# Click Super + Shift + R to hot reload the config
```

## Usage

### Default Keybindings

| Keybind | Action |
|---------|--------|
| `Super + Q` | Spawn terminal |
| `Super + D` | Launch Rofi |
| `Super + C` | Kill focused window |
| `Super + Shift + Q` | Quit OXWM |
| `Super + Shift + R` | Hot reload config |
| `Super + 1-9` | Switch to workspace 1-9 |
| `Super + Shift + 1-9` | Move window to workspace 1-9 |
| `Super + J/K` | Focus next/previous window |
| `Super + H/L` | Decrease/increase master area |
| `Super + A` | Toggle gaps |
| `Super + Shift + F` | Toggle fullscreen |
| `Prt Sc` | Screenshot (Flameshot) |
| `Super + Shift + /` | Show keybind overlay |
| `Alt + Shift` | Change keyboard layout | 

### Keychords

| Sequence | Action |
|----------|--------|
| `Super + Space` → `M` | Spawn Termusic (using st) |
| `Super + Space` → `W` | Spawn Wallpaper/Theme Changer |
| `Super + Space` → `C` | Spawn NMTUI using kitty |
| `Super + Space` → `T` | Spawn a tmux session named "tmuxbtw" |

### Media Keys

Standard media keys work for volume, play/pause, next/previous track.

## Customization

The config is located at `~/.config/oxwm/config.lua`.

### Changing Colors
I included tonybanters' preset color scheme .lua files (tokyonight, gruvbox and nord)
Replace the scheme included in the dotfiles with your own color scheme file if you want.
for example:
```lua
local theme_name = "nord"
local colors = require(theme_name)
```

### Adding Keybinds

```lua
oxwm.key.bind({ modkey }, "YourKey", oxwm.spawn({ "your-command" }))
```

### Hot Reload

After making changes, press `Super + Shift + R` to reload without restarting X.

## Credits

- **OXWM** by [Tonybtw](https://github.com/tonybanters/oxwm)
- **Tokyo Night, Nord, and Gruvbox .lua files** adapted from Tony's config

## Contributing

Feel free to fork this and adapt it to your needs. If you have suggestions or improvements, open an issue or PR!

## License

This config is provided as-is. Do whatever you want with it.
