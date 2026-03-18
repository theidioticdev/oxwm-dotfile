# OXWM Dotfile

OXWM setup I use daily, feek free to use it!
---

## Screenshots

![Desktop](screenshot.png)

---

## What even is OXWM?

it's a dynamic window manager written in Zig, basically dwm but actually bearable to configure. no more recompiling C every time you wanna change a keybind

- **Lua config with hot-reload** - `Super + Shift + R` and you're done, no recompile needed
- **LSP support** - autocomplete in your config file like a normal person
- **Keychord support** - vim-style multi-key bindings
- **Built-in status bar** - no need for polybar or lemonbar
- **Multi-monitor support** - it just works

→ [official repo](https://github.com/tonybanters/oxwm)

---

## My Setup

| thing | what i use |
|-------|------------|
| OS | CachyOS |
| Terminal | Kitty |
| Launcher | Rofi |
| Browser | Brave |
| Editor | Neovim (with Micro for quick edits) |
| Font | Iosevka Nerd Font Propo Bold 12 |
| Music | Termusic (TUI) |
| Compositor | Picom |
| Notifications | Dunst |
| Themes | Catppuccin Mocha, Gruvbox, Tokyo Night, Nord, Oxocarbon |

---

## What's in the bar

the status bar shows: kernel version · RAM usage · date/time · battery · disk usage

all color-coded and underlined per block, each one has its own update interval so it's not killing your CPU

---

## Installation

### Step 1 - Install Dependencies

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
# You can replace yay with paru
yay -S oxwm-git kitty brave-bin rofi flameshot xclip playerctl blueman thunar \
  xwallpaper dunst networkmanager wireplumber xorg-setxkbmap gawk \
  ttf-iosevka-nerd picom betterlockscreen zig lua libx11 libxft freetype2 \
  fontconfig libxinerama termusic
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
sudo apt install -y kitty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst network-manager wireplumber gawk picom \
  lua5.4 libx11-dev libxft-dev libfreetype6-dev \
  libfontconfig1-dev libxinerama-dev
```

> **Iosevka Nerd Font** isn't in apt repos - grab `IosevkaTerm.zip` from [nerd-fonts releases](https://github.com/ryanoasis/nerd-fonts/releases) and install manually:
>
> ```bash
> mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv
> ```

**Install betterlockscreen manually** (not in apt repos):

```bash
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
```

**Install Rust + Cargo** (needed for termusic):

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
```

**Install termusic:**

```bash
cargo install termusic
```

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
sudo dnf install -y kitty brave-browser rofi flameshot xclip playerctl \
  blueman thunar dunst NetworkManager wireplumber gawk picom \
  lua libX11-devel libXft-devel freetype-devel fontconfig-devel libXinerama-devel
```

> **nmtui** ships with NetworkManager - just run `nmtui` in a terminal to manage connections.

**xwallpaper** - easiest via COPR:

```bash
sudo dnf copr enable linuxredneck/xwallpaper
sudo dnf install xwallpaper
```

or build from source if you'd rather not use COPR:

```bash
sudo dnf install -y libX11-devel libXft-devel imlib2-devel
git clone https://github.com/stoeckmann/xwallpaper
cd xwallpaper && ./autogen.sh && ./configure && make && sudo make install
```

> **Iosevka Nerd Font** isn't in Fedora repos - grab `IosevkaTerm.zip` from [nerd-fonts releases](https://github.com/ryanoasis/nerd-fonts/releases) and install manually:
>
> ```bash
> mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv
> ```

**Install betterlockscreen manually** (not in Fedora repos):

```bash
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
```

**Install Rust + Cargo** (needed for termusic):

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
```

**Install termusic:**

```bash
cargo install termusic
```

</details>

<details>
<summary>openSUSE Tumbleweed</summary>

**Add the Brave repo:**

```bash
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo zypper refresh
```

**Add the X11:XOrg repo (needed for picom):**

```bash
sudo zypper addrepo https://download.opensuse.org/repositories/X11:XOrg/openSUSE_Tumbleweed/X11:XOrg.repo
sudo zypper refresh
```

**Install everything:**

```bash
sudo zypper install -y kitty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst NetworkManager \
  wireplumber gawk picom lua libX11-devel libXft-devel freetype2-devel \
  fontconfig-devel libXinerama-devel
```

> **nmtui** ships with NetworkManager - just run `nmtui` in a terminal to manage connections.

**Install betterlockscreen manually** (not in openSUSE repos):

```bash
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
```

**Install Rust + Cargo** (needed for termusic):

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
```

**Install termusic:**

```bash
cargo install termusic
```

> **Iosevka Nerd Font** isn't in openSUSE repos - grab `IosevkaTerm.zip` from [nerd-fonts releases](https://github.com/ryanoasis/nerd-fonts/releases) and install manually:
>
> ```bash
> mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv
> ```

</details>

<details>
<summary>Installing Zig (all distros except Arch)</summary>



**Debian / Ubuntu / Mint** — unofficial apt repo by [dariogriffo](https://github.com/dariogriffo/debian.griffo.io) (not affiliated with ziglang.org):
```bash
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc \
  | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg

echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" \
  | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list

sudo apt update && sudo apt install zig
```

**Fedora / RHEL / openSUSE** — repos are behind, grab it manually:
```bash
wget https://ziglang.org/download/0.15.2/zig-linux-x86_64-0.15.2.tar.xz
tar -xf zig-linux-x86_64-0.15.2.tar.xz
sudo mv zig-linux-x86_64-0.15.2 /opt/zig
echo 'export PATH=$PATH:/opt/zig' >> ~/.bashrc && source ~/.bashrc
```

> on Fedora 42+ or Tumbleweed you can try your package manager first and check with `zig version` — if it's not 0.15.2, use the manual method above.

</details>

---

### Step 2 - Install the Config

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

> **Before the next step** - edit `oxwm-thmctl` to point at your wallpaper directories:
>
> ```bash
> nano oxwm-thmctl  # switch nano for any editor you use (e.g. nvim, micro, emacs, etc...)
> ```

```bash
# Make oxwm-thmctl executable and move it to PATH
chmod +x oxwm-thmctl
sudo cp oxwm-thmctl /usr/local/bin/  # or ~/.local/bin/
```

You don't have to use the included wallpapers - any folder works, just update the paths in `oxwm-thmctl`.

---

## Keybindings

### everyday stuff

| keybind | what it does |
|---------|--------------|
| `Super + Q` | open terminal (Kitty) |
| `Super + D` | Rofi launcher |
| `Super + B` | open Brave |
| `Super + Shift + B` | Bluetooth manager |
| `Super + E` | file manager (Thunar) |
| `Print` | screenshot via Flameshot |
| `Super + C` | kill focused window |
| `Super + Shift + L` | lock screen |
| `Super + Shift + Q` | quit OXWM |
| `Super + Shift + R` | **hot reload config** ← use this constantly |
| `Super + Shift + /` | show keybind overlay |
| `Super + Ctrl + P` | power menu |
| `Alt + Shift` | toggle keyboard layout (US / EG) |

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
| `Super + Space` → `W` | wallpaper / theme switcher (oxwm-thmctl) |
| `Super + Space` → `M` | Termusic (TUI music player) |
| `Super + Space` → `C` | NMTUI (network manager) |
| `Super + Space` → `T` | new tmux session |
| `Super + Space` → `S` | Telegram |

### media keys

volume up/down/mute + play/pause/next/prev all work out of the box via PipeWire/WirePlumber + playerctl

---

## Customization

config lives at `~/.config/oxwm/config.lua` - edit it, hit `Super + Shift + R`, done

### switching color schemes

6 themes are included: `tokyonight`, `gruvbox`, `nord`, `catppuccin`, `oxocarbon`, and `other` (wallpaper-agnostic fallback)

the easiest way is via the theme switcher - `Super + Space` → `W` - it auto-swaps the theme based on your wallpaper folder name and hot-reloads instantly

or change it manually by editing one line in the config:

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

GPL-3.0 - see [LICENSE](LICENSE) for the full text. tl;dr: use it, modify it, share it, just keep it open source
