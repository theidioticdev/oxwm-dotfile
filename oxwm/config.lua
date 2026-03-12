---@meta

--[[
  ██████╗ ██╗  ██╗██╗    ██╗███╗   ███╗    ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗
 ██╔═══██╗╚██╗██╔╝██║    ██║████╗ ████║   ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝
 ██║   ██║ ╚███╔╝ ██║ █╗ ██║██╔████╔██║   ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
 ██║   ██║ ██╔██╗ ██║███╗██║██║╚██╔╝██║   ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
 ╚██████╔╝██╔╝ ██╗╚███╔███╔╝██║ ╚═╝ ██║   ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
  ╚═════╝ ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝     ╚═╝    ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝
 OXWM: dwm, but with saner defaults...
--]]

---@module 'oxwm'

-- ============================================================================
-- VARIABLES
-- ============================================================================

local modkey = "Mod4" -- Super/Windows key (use "Mod1" for Alt)
local terminal = "kitty"
local theme_name = "other"

local colors = require(theme_name)

-- Workspace tags (icons shown in bar)
local tags = {
    "", -- 1: Terminal
    "󰊯", -- 2: Browser
    "󰕼", -- 3: Media
    "", -- 4: Tmux and coding
    "󰙯", -- 5: Telegram
    "󱇤", -- 6: Work
    "", -- 7: Misc
    "󰊴", -- 8: Games
    "", -- 9: Files
}

-- Status bar font (run "fc-list" to see available fonts)
local bar_font = "Iosevka Nerd Font Propo:style=Bold:size=12"

-- ============================================================================
-- BASIC SETTINGS
-- ============================================================================

oxwm.set_terminal(terminal)
oxwm.set_modkey(modkey) -- Used for Mod + mouse binds (drag/resize)
oxwm.set_tags(tags)

-- ============================================================================
-- APPEARANCE
-- ============================================================================

-- Window borders
oxwm.border.set_width(2)
oxwm.border.set_focused_color(colors.purple)
oxwm.border.set_unfocused_color(colors.sep)

-- Gaps
-- Smart gaps: no border/gaps when only 1 window is visible
oxwm.gaps.set_smart(true)
oxwm.gaps.set_inner(5, 5) -- (horizontal, vertical) in pixels
oxwm.gaps.set_outer(5, 5) -- (horizontal, vertical) in pixels

-- ============================================================================
-- LAYOUTS
-- ============================================================================

oxwm.set_layout_symbol("tiling", "󰹫 Tiling")
oxwm.set_layout_symbol("normie", "󰕣 Normie")
oxwm.set_layout_symbol("monocle", "◻ Monocle")
oxwm.set_layout_symbol("scrolling", "↕ Scrolling")

-- ============================================================================
-- STATUS BAR BLOCKS
-- ============================================================================

local ram = oxwm.bar.block.ram({
    format = "󰍛 Ram: {used}/{total} GB",
    interval = 1,
    color = colors.light_blue,
    underline = true,
})

local kernel = oxwm.bar.block.shell({
    format = " {}",
    command = "uname -r",
    interval = 999999999, -- effectively static
    color = colors.red,
    underline = true,
})

local date = oxwm.bar.block.datetime({
    format = "󰸘 {}",
    date_format = "%a, %b %d - %-I:%M %P",
    interval = 1,
    color = colors.cyan,
    underline = true,
})

local battery = oxwm.bar.block.battery({
    format = "󰁹 {}%",
    charging = "⚡󰁹 {}%",
    discharging = "-󰁹 {}%",
    full = "✓󰁹 {}%",
    interval = 10,
    color = colors.green,
    underline = true,
})

local sep = oxwm.bar.block.static({
    text = "│",
    interval = 999999999,
    color = colors.sep,
    underline = false,
})

-- Keyboard layout indicator (shows "EG" or "US")
local kbd = oxwm.bar.block.shell({
    format = "󰌌 {}",
    command = 'xset -q | grep LED | awk \'{ print (substr($10,5,1) == "1") ? "EG" : "US" }\'',
    interval = 1,
    color = colors.purple,
    underline = true,
})

-- Bar block order (left to right)
local blocks = {
    kernel,
    sep,
    kbd,
    sep,
    ram,
    sep,
    date,
    sep,
    battery,
}

oxwm.bar.set_font(bar_font)
oxwm.bar.set_blocks(blocks)

-- Bar tag color schemes: (foreground, background, border)
oxwm.bar.set_scheme_normal(colors.fg, colors.bg, "#444444")         -- Unoccupied
oxwm.bar.set_scheme_occupied(colors.cyan, colors.bg, colors.cyan)   -- Occupied
oxwm.bar.set_scheme_selected(colors.cyan, colors.bg, colors.purple) -- Selected

-- ============================================================================
-- WINDOW RULES
-- Assign apps to tags and set floating behavior
-- ============================================================================

-- Floating windows
oxwm.rule.add({ instance = "floating", floating = true })
oxwm.rule.add({ instance = "pop-up", floating = true })
oxwm.rule.add({ instance = "gimp", floating = true })
oxwm.rule.add({ instance = "Godot_Editor", floating = true })
oxwm.rule.add({ instance = "blueman-manager", floating = true })
oxwm.rule.add({ instance = "connect", floating = true })

-- Tag assignments
oxwm.rule.add({ instance = "kitty", tag = 1 })
oxwm.rule.add({ instance = "brave-browser", tag = 2 })
oxwm.rule.add({ instance = "vlc", tag = 3 })
oxwm.rule.add({ instance = "music", tag = 3 })
oxwm.rule.add({ instance = "tmuxbtw", tag = 4 })
oxwm.rule.add({ instance = "Telegram", tag = 5 })
oxwm.rule.add({ instance = "connect", tag = 6 })
oxwm.rule.add({ instance = "libreoffice-writer", tag = 6 })
oxwm.rule.add({ instance = "libreoffice-calc", tag = 6 })
oxwm.rule.add({ instance = "libreoffice", tag = 6 })
oxwm.rule.add({ instance = "Terraria.bin.x86_64", tag = 8 })
oxwm.rule.add({ instance = "itch", tag = 8 })
oxwm.rule.add({ instance = "uzdoom", tag = 8 })
oxwm.rule.add({ instance = "thunar", tag = 9 })

-- ============================================================================
-- KEYBINDINGS
-- ============================================================================

-- ── App Launchers ────────────────────────────────────────────────────────────
oxwm.key.bind({ modkey }, "Q", oxwm.spawn_terminal())
oxwm.key.bind({ modkey }, "D", oxwm.spawn({ "~/.config/rofi/launchers/type-4/launcher.sh" }))
oxwm.key.bind({ modkey }, "B", oxwm.spawn({ "brave" }))
oxwm.key.bind({ modkey, "Shift" }, "B", oxwm.spawn({ "blueman-manager" }))
oxwm.key.bind({ modkey }, "E", oxwm.spawn({ "thunar" }))
oxwm.key.bind({ "Mod1" }, "T", oxwm.spawn({ "kitty --class floating" }))
oxwm.key.bind({}, "Print", oxwm.spawn({ "~/dotfiles/oxwm-dotfile/screenshot.sh" }))
-- ── Window Management ────────────────────────────────────────────────────────
oxwm.key.bind({ modkey }, "C", oxwm.client.kill())
oxwm.key.bind({ modkey, "Shift" }, "F", oxwm.client.toggle_fullscreen())
oxwm.key.bind({ modkey, "Shift" }, "Space", oxwm.client.toggle_floating())
oxwm.key.bind({ modkey }, "J", oxwm.client.focus_stack(1))
oxwm.key.bind({ modkey }, "K", oxwm.client.focus_stack(-1))
oxwm.key.bind({ modkey, "Shift" }, "J", oxwm.client.move_stack(1))
oxwm.key.bind({ modkey, "Shift" }, "K", oxwm.client.move_stack(-1))
oxwm.key.bind({ modkey, "Shift" }, "L", oxwm.spawn({ "betterlockscreen -l" }))

-- ── Layouts ──────────────────────────────────────────────────────────────────
oxwm.key.bind({ modkey }, "T", oxwm.layout.set("tiling"))
oxwm.key.bind({ modkey }, "N", oxwm.layout.cycle())
oxwm.key.bind({ modkey }, "S", oxwm.layout.scroll_left())
oxwm.key.bind({ modkey, "Shift" }, "S", oxwm.layout.scroll_right())

-- ── Master Area (Tiling) ─────────────────────────────────────────────────────
oxwm.key.bind({ modkey }, "H", oxwm.set_master_factor(-5)) -- Shrink master
oxwm.key.bind({ modkey }, "L", oxwm.set_master_factor(5))  -- Grow master
oxwm.key.bind({ modkey }, "I", oxwm.inc_num_master(1))     -- More masters
oxwm.key.bind({ modkey }, "P", oxwm.inc_num_master(-1))    -- Fewer masters

-- ── Gaps ─────────────────────────────────────────────────────────────────────
oxwm.key.bind({ modkey }, "A", oxwm.toggle_gaps())

-- ── WM Controls ──────────────────────────────────────────────────────────────
oxwm.key.bind({ modkey, "Shift" }, "Q", oxwm.quit())
oxwm.key.bind({ modkey, "Shift" }, "R", oxwm.restart())
oxwm.key.bind({ modkey, "Shift" }, "Slash", oxwm.show_keybinds())
oxwm.key.bind({ modkey, "Control" }, "P", oxwm.spawn({ "~/.config/rofi/powermenu/type-4/powermenu.sh" }))

-- ── Multi-Monitor ────────────────────────────────────────────────────────────
oxwm.key.bind({ modkey }, "Comma", oxwm.monitor.focus(-1))
oxwm.key.bind({ modkey }, "Period", oxwm.monitor.focus(1))
oxwm.key.bind({ modkey, "Shift" }, "Comma", oxwm.monitor.tag(-1))
oxwm.key.bind({ modkey, "Shift" }, "Period", oxwm.monitor.tag(1))

-- ── Workspace Navigation (tags are 0-indexed) ────────────────────────────────
-- View tag
for i = 1, 9 do
    oxwm.key.bind({ modkey }, tostring(i), oxwm.tag.view(i - 1))
    oxwm.key.bind({ modkey, "Shift" }, tostring(i), oxwm.tag.move_to(i - 1))
    oxwm.key.bind({ modkey, "Control" }, tostring(i), oxwm.tag.toggleview(i - 1))
    oxwm.key.bind({ modkey, "Control", "Shift" }, tostring(i), oxwm.tag.toggletag(i - 1))
end

-- ── Media Controls ───────────────────────────────────────────────────────────
oxwm.key.bind({}, "XF86AudioRaiseVolume", oxwm.spawn({ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+" }))
oxwm.key.bind({}, "XF86AudioLowerVolume", oxwm.spawn({ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" }))
oxwm.key.bind({}, "XF86AudioMute", oxwm.spawn({ "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" }))
oxwm.key.bind({}, "XF86AudioPlay", oxwm.spawn({ "playerctl play-pause" }))
oxwm.key.bind({}, "XF86AudioStop", oxwm.spawn({ "playerctl stop" }))
oxwm.key.bind({}, "XF86AudioNext", oxwm.spawn({ "playerctl next" }))
oxwm.key.bind({}, "XF86AudioPrev", oxwm.spawn({ "playerctl previous" }))

-- ── Keychords (Mod + Space, then...) ─────────────────────────────────────────
oxwm.key.chord({
    { { modkey }, "Space" },
    { {},         "W" },
}, oxwm.spawn({ "oxwm-thmctl" }))

oxwm.key.chord({
    { { modkey }, "Space" },
    { {},         "M" },
}, oxwm.spawn({ "kitty --class music -e termusic" }))

oxwm.key.chord({
    { { modkey }, "Space" },
    { {},         "C" },
}, oxwm.spawn({ "kitty --class connect -e nmtui" }))

oxwm.key.chord({
    { { modkey }, "Space" },
    { {},         "T" },
}, oxwm.spawn({ "kitty --class tmuxbtw -e tmux new -s tmuxbtw" }))

oxwm.key.chord({
    { { modkey }, "Space" },
    { {},         "S" },
}, oxwm.spawn({ "Telegram" }))
-- ============================================================================
-- AUTOSTART
-- ============================================================================

oxwm.autostart("xset r rate 200 35")                                 -- Key repeat rate
oxwm.autostart("picom")                                              -- Compositor
oxwm.autostart("xwallpaper --zoom ~/.local/share/current_wallpaper") -- Wallpaper
oxwm.autostart("dunst")                                              -- Notifications
oxwm.autostart("xss-lock -- betterlockscreen -l")                    -- Screen lock on idle
