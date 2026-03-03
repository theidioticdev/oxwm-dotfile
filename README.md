# OXWM Dotfile

my personal OXWM + fastfetch + bashrc setup. steal it, fork it, whatever — just don't blame me if something breaks lol

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
<summary>Arch / CachyOS (recommended)</summary>

**One-liner:**
```bash
bash <(wget -qO- https://raw.githubusercontent.com/theidioticdev/oxwm-dotfile/main/install.sh)
```

or with curl:
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/theidioticdev/oxwm-dotfile/main/install.sh)
```

or manually:
```bash
yay -S oxwm-git alacritty brave-bin rofi flameshot xclip playerctl blueman thunar \
  xwallpaper dunst network-manager-applet wireplumber xorg-setxkbmap gawk \
  ttf-iosevka-nerd picom betterlockscreen zig lua libx11 libxft freetype2 \
  fontconfig libxinerama
```

</details>

<details>
<summary>Debian / Ubuntu / Mint</summary>

**Add the Brave repo:**
```bash
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
  https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] \
  https://brave-browser-apt-release.s3.brave.com/ stable main" \
  | sudo tee /etc/apt/sources.list.d/brave-browser.list

sudo apt update
```

**Install everything:**
```bash
sudo apt install -y alacritty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst network-manager-gnome wireplumber gawk picom \
  fonts-iosevka-nerd zig lua5.4 libx11-dev libxft-dev libfreetype6-dev \
  libfontconfig1-dev libxinerama-dev
```

**Install betterlockscreen manually** (not in apt repos):
```bash
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
```

> **Iosevka Nerd Font not in your repos?** Grab `IosevkaTerm.zip` from [nerd-fonts releases](https://github.com/ryanoasis/nerd-fonts/releases) and install manually:
> ```bash
> mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv
> ```

> **Zig not in apt?** Either use snap:
> ```bash
> sudo snap install zig --classic --beta
> ```
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

**Add the Brave repo:**
```bash
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo \
  https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
```

**Install everything:**
```bash
sudo dnf install -y alacritty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst NetworkManager-tui wireplumber gawk picom \
  zig lua libX11-devel libXft-devel freetype-devel fontconfig-devel libXinerama-devel
```

**Install betterlockscreen manually** (not in Fedora repos):
```bash
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
```

> **Iosevka Nerd Font** isn't in Fedora repos — grab `IosevkaTerm.zip` from [nerd-fonts releases](https://github.com/ryanoasis/nerd-fonts/releases) and install manually:
> ```bash
> mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv
> ```

> **Alacritty missing?** Fall back to:
> ```bash
> sudo dnf install -y cargo && cargo install alacritty
> ```

</details>

<details>
<summary>openSUSE Tumbleweed</summary>

**Add the Brave repo:**
```bash
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo zypper refresh
```

**Install everything:**
```bash
sudo zypper install -y alacritty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst NetworkManager network-manager-applet \
  wireplumber gawk picom zig lua54 libX11-devel libXft-devel freetype2-devel \
  fontconfig-devel libXinerama-devel
```

**Install betterlockscreen manually** (not in openSUSE repos):
```bash
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
```

> **Iosevka Nerd Font** isn't in openSUSE repos — grab `IosevkaTerm.zip` from [nerd-fonts releases](https://github.com/ryanoasis/nerd-fonts/releases) and install manually:
> ```bash
> mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv
> ```

</details>

---

### Step 2 — Install the Config

```bash
# Clone the repo
git clone https://github.com/theidioticdev/oxwm-dotfile
cd oxwm-dotfile

# Back up existing configs (safe to run even if they don't exist)
[ -d ~/.config/oxwm ]      && mv ~/.config/oxwm      ~/.config/oxwm_backup
[ -d ~/.config/fastfetch ] && mv ~/.config/fastfetch  ~/.config/fastfetch_backup
[ -f ~/.bashrc ]           && mv ~/.bashrc             ~/.bashrc_backup

# Copy configs
cp -r ./oxwm ~/.config/
cp -r ./fastfetch ~/.config/

# Copy wallpapers
mkdir -p ~/dotfiles/
cp -r ./walls ~/dotfiles/
```

> **Before the next step** — edit `wallmenu` to point at your wallpaper directories:
> ```bash
> nano wallmenu
> ```

```bash
# Make wallmenu executable and move it to PATH
chmod +x wallmenu
sudo cp wallmenu /usr/local/bin/
```

You don't have to use the included wallpapers — any folder works, just update the paths in `wallmenu`.

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
| `Super + Space` → `C` | NMTUI (TUI-based NetworkManager program) |
| `Super + Space` → `T` | new tmux session named "tmux-btw" |
| `Super + Space` → `S` | Telegram |

### media keys

volume up/down/mute + play/pause/next/prev all work out of the box via PipeWire/WirePlumber + playerctl

---

## Customization

config lives at `~/.config/oxwm/config.lua` — edit it, hit `Super + Shift + R`, done

### switching color schemes

6 themes are included: `tokyonight`, `gruvbox`, `nord`, `catppuccin`, `oxocarbon`, and `Wallpaper Agnostic (other)`

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
oxwm.rule.add({ instance = "your-app", tag = 3 })         -- auto-send to workspace 3
oxwm.rule.add({ instance = "your-app", floating = true })  -- always float
```

```bash
# to find the WM class of an app for use in rules:
xprop WM_CLASS
```

---

## Contributing

fork it, break it, make it yours. issues and PRs are welcome if you've got something good

## License

do whatever you want with it lol
