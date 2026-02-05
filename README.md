# OXWM Dotfiles

My personal OXWM configuration, feel free to try it out!

![Screenshot](screenshot.png)

## What is OXWM?

OXWM is a dynamic window manager written in Rust, inspired by dwm but with modern improvements:
- Lua configuration with hot-reload (no recompiling!)
- LSP support for config autocomplete
- Keychord support for advanced keybindings
- Built-in status bar
- Multi-monitor support

Check out the [official repo](https://github.com/tonybanters/oxwm) for more info.

## My Setup

- **OS**: CachyOS (Arch-based with performance optimizations)
- **WM**: OXWM
- **Display Manager**: Ly (minimal TUI display manager 
- **Terminal**: Kitty
- **Launcher**: Rofi
- **Browser**: Brave
- **Theme**: Tokyo Night
- **Font**: JetBrains Mono Nerd Font

## Features

- **Clean status bar** with kernel info, RAM usage, battery, volume, keyboard layout, and date/time
- **Workspace tags** using nerd font icons instead of numbers
- **Keychords** for advanced keybinds (Mod+Space + key combos)
- **Window rules** for auto-tagging apps to specific workspaces
- **Dual keyboard layout** (US/Arabic) with Alt+Shift toggle
- **Media controls** for PipeWire/WirePlumber
- **Modular config** with separate color scheme file

## Installation

### Dependencies

```bash
# Core
yay -S oxwm-git

# Additional tools used in config
yay -S kitty rofi dunst nm-applet xwallpaper flameshot \
       pipewire wireplumber playerctl ttf-jetbrains-mono-nerd
```

### Display Manager (Ly) (you could skip this, any Display Manager works fine)

```bash
yay -S ly
sudo systemctl enable ly@tty1 (anything tty works fine)
```

### Installing the Config

```bash
# Clone this repo
git clone https://github.com/YOUR_USERNAME/oxwm-dotfile
cd oxwm-dotfile

# Backup existing config if you have one
mv ~/.config/oxwm ~/.config/oxwm.backup

# Copy config
cp -r oxwm ~/.config/

# Copy wallpaper (adjust path as needed)
mkdir -p ~/path/to/wallpapers
cp wallpapers/dunes.png (or any wallpaper you have) ~/path/to/wallpapers/

# Restart OXWM or log out and back in
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
| `Super + S` | Screenshot (Flameshot) |
| `Super + Shift + /` | Show keybind overlay |

### Keychords

| Sequence | Action |
|----------|--------|
| `Super + Space` → `T` | Spawn terminal |
| `Super + Space` → `B` | Launch Brave |
| `Super + Space` → `G` | Launch GIMP |

### Media Keys

Standard media keys work for volume, play/pause, next/previous track.

## Customization

The config is located at `~/.config/oxwm/config.lua`.

### Changing Colors

Edit `~/.config/oxwm/tokyonight.lua` or replace it with your own color scheme file.

### Adding Keybinds

```lua
oxwm.key.bind({ modkey }, "YourKey", oxwm.spawn({ "your-command" }))
```

### Hot Reload

After making changes, press `Super + Shift + R` to reload without restarting X.

## Credits

- **OXWM** by [Tony](https://github.com/tonybanters/oxwm)
- **Tokyo Night color scheme** adapted from Tony's config
- Inspired by the dwm and tiling WM community

## Contributing

Feel free to fork this and adapt it to your needs. If you have suggestions or improvements, open an issue or PR!

## License

This config is provided as-is. Do whatever you want with it.
