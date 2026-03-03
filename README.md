# OXWM Dotfile

my personal OXWM + fastfetch setup. steal it, fork it, whatever — just don't blame me if something breaks lol

---

## Screenshots

![Desktop](screenshot.png)
![Floating Windows](floatingwindows.png)

---

## What even is OXWM?

it's a dynamic window manager written in Zig, basically dwm but actually bearable to configure. no more recompiling C every time you wanna change a keybind fr

- **Lua config with hot-reload** — `Super + Shift + R` and you're done, no recompile needed
- **LSP support** — autocomplete in your config file like a normal person
- **Keychord support** — vim-style multi-key bindings
- **Built-in status bar** — no need for polybar or lemonbar
- **Multi-monitor support** — it just works

→ [official repo](https://github.com/tonybanters/oxwm)

---

## My Setup

| thing | what i use |
|-------|------------|
| OS | CachyOS |
| Terminal | Alacritty (alt: Kitty) |
| Launcher | Rofi + dmenu |
| Browser | Brave |
| Font | Iosevka Nerd Font Propo |
| Themes | Catppuccin Mocha, Gruvbox, Tokyo Night, Nord, Oxocarbon |

---

## What's in the bar

the status bar shows: kernel version · RAM usage · volume · date/time · keyboard layout · battery · disk usage

all color-coded and underlined per block, each one has its own update interval so it's not killing your CPU

---

## Installation

### Step 1 — Install Dependencies


<details>
<summary>Arch / CachyOS (recommended tbh)</summary>

```bash
bash <(wget -qO- https://raw.githubusercontent.com/theidioticdev/oxwm-dotfile/main/install.sh)
```

or with curl:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/theidioticdev/oxwm-dotfile/main/install.sh)
```

or manually with yay/paru:

```bash
yay -S oxwm-git alacritty brave-bin rofi flameshot xclip playerctl blueman thunar \
  xwallpaper dunst network-manager-applet wireplumber xorg-setxkbmap gawk \
  ttf-iosevka-nerd zig lua libx11 libxft freetype2 fontconfig libxinerama
```

</details>

<details>
<summary>Debian / Ubuntu / Mint</summary>

```bash
# Add Brave repo
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
  https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] \
  https://brave-browser-apt-release.s3.brave.com/ stable main" \
  | sudo tee /etc/apt/sources.list.d/brave-browser.list

sudo apt update

# Install everything
sudo apt install -y alacritty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst network-manager-gnome wireplumber gawk \
  fonts-iosevka-nerd zig lua5.4 libx11-dev libxft-dev libfreetype6-dev \
  libfontconfig1-dev libxinerama-dev
```

> **heads up:** `fonts-iosevka-nerd` might not exist on older releases. grab it manually from [nerd-fonts releases](https://github.com/ryanoasis/nerd-fonts/releases) (IosevkaTerm.zip), then:
> ```bash
> mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv
> ```

> **zig not in apt?** either use snap: `sudo snap install zig --classic --beta`
> or grab it directly:
> ```bash
> wget https://ziglang.org/download/0.15.2/zig-linux-x86_64-0.15.2.tar.xz
> tar -xf zig-linux-x86_64-0.15.2.tar.xz
> sudo mv zig-linux-x86_64-0.15.2 /opt/zig
> echo 'export PATH=$PATH:/opt/zig' >> ~/.bashrc && source ~/.bashrc
> ```

</details>

<details>
<summary>Fedora / RHEL / Rocky / Alma</summary>

```bash
# Add Brave repo
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo \
  https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# Install everything
sudo dnf install -y alacritty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst NetworkManager-tui wireplumber gawk \
  zig lua libX11-devel libXft-devel freetype-devel fontconfig-devel libXinerama-devel
```

> **Iosevka Nerd Font** isn't in Fedora repos — grab it from [nerd-fonts releases](https://github.com/ryanoasis/nerd-fonts/releases) (IosevkaTerm.zip)

> **alacritty missing?** fallback: `sudo dnf install -y cargo && cargo install alacritty`

</details>

<details>
<summary>openSUSE Tumbleweed</summary>

```bash
# Add Brave repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo zypper refresh

# Install everything
sudo zypper install -y alacritty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst NetworkManager network-manager-applet \
  wireplumber gawk zig lua54 libX11-devel libXft-devel freetype2-devel \
  fontconfig-devel libXinerama-devel
```

> **Iosevka Nerd Font** — grab it from [nerd-fonts releases](https://github.com/ryanoasis/nerd-fonts/releases) (IosevkaTerm.zip)

</details>

---

### Step 2 — Install the Config

```bash
# Clone the repo
git clone https://github.com/theidioticdev/oxwm-dotfile
cd oxwm-dotfile

# Backup existing configs (safe to run even if they don't exist)
[ -d ~/.config/oxwm ] && mv ~/.config/oxwm ~/.config/oxwm_backup
[ -d ~/.config/fastfetch ] && mv ~/.config/fastfetch ~/.config/fastfetch_backup

# Copy configs
cp -r ./oxwm ~/.config/
cp -r ./fastfetch ~/.config/

# Copy wallpapers
mkdir -p ~/dotfiles/
cp -r ./walls ~/dotfiles/
```

> **before the next step** — edit `wallmenu` to point at your wallpaper directories:
> ```bash
> nano wallmenu
> ```

```bash
# Make wallmenu executable and install it
chmod +x wallmenu
sudo cp wallmenu /usr/local/bin/
```

you don't have to use my wallpapers btw, any folder works — just tweak the paths in `wallmenu`

---

## Keybindings

### everyday stuff

| keybind | what it does |
|---------|--------------|
| `Super + Q` | open terminal (Alacritty) |
| `Super + Shift + T` | open alt terminal (Kitty) |
| `Super + D` | Rofi launcher |
| `Super + Shift + D` | dmenu (actually useful paired with rofi) |
| `Super + B` | open Brave |
| `Super + Shift + B` | Bluetooth manager |
| `Super + E` | file manager (Thunar) |
| `Super + V` | VLC |
| `Print` | screenshot via Flameshot |
| `Super + C` | kill focused window |
| `Super + Shift + Q` | quit OXWM |
| `Super + Shift + R` | **hot reload config** ← use this constantly |
| `Super + Shift + /` | show keybind overlay |
| `Alt + Shift` | toggle keyboard layout (US / Arabic) |

### window & layout

| keybind | what it does |
|---------|--------------|
| `Super + J / K` | focus up / down the stack |
| `Super + Shift + J / K` | move window up / down the stack |
| `Super + H / L` | shrink / grow master area |
| `Super + I / P` | more / fewer master windows |
| `Super + T` | set tiling layout |
| `Super + N` | cycle through layouts |
| `Super + S / Shift+S` | scroll layout left / right |
| `Super + A` | toggle gaps |
| `Super + Shift + F` | toggle fullscreen |
| `Super + Shift + Space` | toggle floating |
| `Super + Shift + L` | lock screen |

### workspaces

| keybind | what it does |
|---------|--------------|
| `Super + 1-9` | switch to workspace |
| `Super + Shift + 1-9` | move window to workspace |
| `Super + Ctrl + 1-9` | toggle-view multiple workspaces at once |
| `Super + Ctrl + Shift + 1-9` | pin window to multiple workspaces |

### multi-monitor

| keybind | what it does |
|---------|--------------|
| `Super + ,` / `Super + .` | focus prev / next monitor |
| `Super + Shift + ,` / `Super + Shift + .` | move window to prev / next monitor |

### keychords (Super + Space → key)

| sequence | what it does |
|----------|--------------|
| `Super + Space` → `W` | wallpaper / theme changer |
| `Super + Space` → `M` | Termusic (music player) |
| `Super + Space` → `C` | NMTUI network manager (in Kitty) |
| `Super + Space` → `T` | new tmux session named "tmux-btw" |
| `Super + Space` → `S` | Telegram |

### media keys

volume up/down/mute + play/pause/next/prev all work out of the box via PipeWire/WirePlumber + playerctl

---

## Customization

config lives at `~/.config/oxwm/config.lua` — edit it, hit `Super + Shift + R`, done

### switching color schemes

5 themes are included: `tokyonight`, `gruvbox`, `nord`, `catppuccin`, `oxocarbon`

change this one line in the config:

```lua
local theme_name = "nord" -- swap this out
```

### adding keybinds

```lua
oxwm.key.bind({ modkey }, "YourKey", oxwm.spawn({ "your-command" }))
```

### adding window rules

```lua
oxwm.rule.add({ instance = "your-app", tag = 3 })          -- auto-send to workspace 3
oxwm.rule.add({ instance = "your-app", floating = true })  -- always float
```

---

## Contributing

fork it, break it, make it yours. issues and PRs are welcome if you've got something good

## License

do whatever you want with it lol
