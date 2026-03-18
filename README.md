# OXWM Dotfile

my personal OXWM + fastfetch + bashrc setup. steal it, fork it, whatever - just don't blame me if something breaks lol

---

## Screenshots

![Desktop](screenshot.png)
![Floating Windows](floatingwindows.png)

---

## What even is OXWM?

dynamic window manager written in Zig. basically dwm but you configure it with Lua instead of recompiling C every time you want to change a keybind.

- **Lua config with hot-reload** — `Super + Shift + R`, no recompile needed
- **LSP support** — autocomplete in your config like a normal person
- **Keychord support** — vim-style multi-key bindings
- **Built-in status bar** — no polybar/lemonbar needed
- **Multi-monitor support** — it just works

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

kernel version · RAM usage · date/time · battery · disk usage

color-coded and underlined per block, each with its own update interval.

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
# you can replace yay with paru
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
```

**Add the Zig repo** (unofficial community repo by [dariogriffo](https://github.com/dariogriffo/debian.griffo.io) — not affiliated with ziglang.org):

```bash
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc \
  | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg

echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" \
  | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
```

**Install everything:**

```bash
sudo apt update
sudo apt install -y kitty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst network-manager wireplumber gawk picom \
  zig lua5.4 libx11-dev libxft-dev libfreetype6-dev \
  libfontconfig1-dev libxinerama-dev
```

> **Zig not installing from the repo above?** Grab it manually from [ziglang.org/download](https://ziglang.org/download) — download the `zig-linux-x86_64-0.15.2.tar.xz`, then:
>
> ```bash
> tar -xf zig-linux-x86_64-0.15.2.tar.xz
> sudo mv zig-linux-x86_64-0.15.2 /opt/zig
> echo 'export PATH=$PATH:/opt/zig' >> ~/.bashrc && source ~/.bashrc
> ```

**Iosevka Nerd Font** — not in apt repos, install manually:

```bash
# grab IosevkaTerm.zip from https://github.com/ryanoasis/nerd-fonts/releases
mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv
```

**betterlockscreen** — not in apt repos:

```bash
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
```

**Rust + Cargo** (needed for termusic):

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
cargo install termusic
```

> **Kitty not in your repos?**
>
> ```bash
> curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
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
sudo dnf install -y kitty brave-browser rofi flameshot xclip playerctl \
  blueman thunar dunst NetworkManager wireplumber gawk picom \
  lua libX11-devel libXft-devel freetype-devel fontconfig-devel libXinerama-devel
```

> **nmtui** ships with NetworkManager — run `nmtui` to manage connections.

**Install Zig** — the Fedora/EPEL repos are behind, so grab it manually:

```bash
wget https://ziglang.org/download/0.15.2/zig-linux-x86_64-0.15.2.tar.xz
tar -xf zig-linux-x86_64-0.15.2.tar.xz
sudo mv zig-linux-x86_64-0.15.2 /opt/zig
echo 'export PATH=$PATH:/opt/zig' >> ~/.bashrc && source ~/.bashrc
```

> **On Fedora 42+** you can try `sudo dnf install zig` first and check the version with `zig version`. If it's not 0.15.2, use the manual method above.

**xwallpaper** — via COPR:

```bash
sudo dnf copr enable linuxredneck/xwallpaper
sudo dnf install xwallpaper
```

> prefer not to use COPR? build from source:
>
> ```bash
> sudo dnf install -y libX11-devel libXft-devel imlib2-devel
> git clone https://github.com/stoeckmann/xwallpaper
> cd xwallpaper && ./autogen.sh && ./configure && make && sudo make install
> ```

**Iosevka Nerd Font** — grab `IosevkaTerm.zip` from [nerd-fonts releases](https://github.com/ryanoasis/nerd-fonts/releases):

```bash
mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv
```

**betterlockscreen** — not in Fedora repos:

```bash
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
```

**Rust + Cargo** (needed for termusic):

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
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

**Add the X11:XOrg repo** (needed for picom):

```bash
sudo zypper addrepo https://download.opensuse.org/repositories/X11:XOrg/openSUSE_Tumbleweed/X11:XOrg.repo
sudo zypper refresh
```

**Install everything:**

```bash
sudo zypper install -y kitty brave-browser rofi flameshot xclip playerctl \
  blueman thunar xwallpaper dunst NetworkManager \
  wireplumber gawk picom zig lua libX11-devel libXft-devel freetype2-devel \
  fontconfig-devel libXinerama-devel
```

> **nmtui** ships with NetworkManager — run `nmtui` to manage connections.

**Iosevka Nerd Font** — grab `IosevkaTerm.zip` from [nerd-fonts releases](https://github.com/ryanoasis/nerd-fonts/releases):

```bash
mkdir -p ~/.local/share/fonts && cp *.ttf ~/.local/share/fonts && fc-cache -fv
```

**betterlockscreen** — not in openSUSE repos:

```bash
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
```

**Rust + Cargo** (needed for termusic):

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
cargo install termusic
```

</details>

---

### Step 2 - Install the Config

```bash
git clone https://github.com/theidioticdev/oxwm-dotfile
cd oxwm-dotfile

# back up existing configs (safe to run even if they don't exist)
[ -d ~/.config/oxwm ]      && mv ~/.config/oxwm      ~/.config/oxwm_backup
[ -d ~/.config/fastfetch ] && mv ~/.config/fastfetch  ~/.config/fastfetch_backup
[ -f ~/.bashrc ]           && mv ~/.bashrc             ~/.bashrc_backup

# copy configs
cp -r ./oxwm ~/.config/
cp -r ./fastfetch ~/.config/

# copy wallpapers
mkdir -p ~/dotfiles/
cp -r ./walls ~/dotfiles/
```

**Before the next step** — edit `oxwm-thmctl` to point at your wallpaper directories:

```bash
nano oxwm-thmctl  # or nvim, micro, emacs, whatever
```

```bash
chmod +x oxwm-thmctl
sudo cp oxwm-thmctl /usr/local/bin/  # or ~/.local/bin/
```

You don't have to use the included wallpapers — any folder works, just update the paths in `oxwm-thmctl`.

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
| `Super + Ctrl + 1-9` | toggle-view multiple workspaces |
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

volume up/down/mute + play/pause/next/prev all work out of the box via PipeWire/WirePlumber + playerctl.

---

## Customization

config lives at `~/.config/oxwm/config.lua` — edit it, hit `Super + Shift + R`, done.

### switching themes

6 themes included: `tokyonight`, `gruvbox`, `nord`, `catppuccin`, `oxocarbon`, `other` (wallpaper-agnostic fallback)

easiest way is the theme switcher — `Super + Space` → `W` — auto-swaps based on wallpaper folder name and hot-reloads instantly.

or manually change one line in the config:

```lua
local theme_name = "nord" -- swap this out
```

### keybinds

```lua
oxwm.key.bind({ modkey }, "YourKey", oxwm.spawn({ "your-command" }))
```

### window rules

```lua
oxwm.rule.add({ instance = "your-app", tag = 3 })         -- auto-send to workspace 3
oxwm.rule.add({ instance = "your-app", floating = true })  -- always float
```

```bash
# find the WM class of an app:
xprop WM_CLASS
```

---

## Contributing

fork it, break it, make it yours. issues and PRs welcome.

## License

GPL-3.0 — see [LICENSE](LICENSE). tl;dr: use it, modify it, share it, keep it open source.
