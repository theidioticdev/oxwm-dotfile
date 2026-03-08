---@meta

------------------------------------
---       ~ OXWM Config ~        ---
---      By: TheIdioticDev       ---
------------------------------------

---@module 'oxwm'

-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------

-- Modifier key: "Mod4" = Super/Windows key | "Mod1" = Alt
local modkey = "Mod4"

local terminal = "kitty"

local theme_name = "tokyonight"

local colors = require(theme_name)

-- Workspace tags
local tags = { "", "󰊯", "󰕼", "", "󰙯", "󱇤", "", "󰊴", "" }

-- Font for the status bar (use "fc-list" to see available fonts)
local bar_font = "Iosevka Nerd Font Propo:style=Bold:size=12"

-------------------------------------------------------------------------------
-- Bar Blocks
-------------------------------------------------------------------------------

local ram = oxwm.bar.block.ram({
	format = "󰍛 Ram: {used}/{total} GB",
	interval = 1,
	color = colors.light_blue,
	underline = true,
})

local kernel = oxwm.bar.block.shell({
	format = "  {}",
	command = "uname -r",
	interval = 999999999,
	color = colors.red,
	underline = true,
})

local storage = oxwm.bar.block.shell({
	command = "df -h / | awk 'NR==2 {print \"󰋊 \" $5}'",
	interval = 60,
	color = colors.green,
	underline = true,
})
local layout = oxwm.bar.block.shell({
	command = "setxkbmap -query | awk '/layout/ {print $2}'",
	interval = 2,
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

local volume = oxwm.bar.block.shell({
	command = 'wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk \'{print ($3 == "[MUTED]" ? "󰝟 Muted" : "󰕾 " $2*100 "%")}\'',
	interval = 1,
	color = colors.purple,
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

-------------------------------------------------------------------------------------------------------------
-- Bar
-------------------------------------------------------------------------------------------------------------
local blocks = {
	kernel,
	sep,
	ram,
	sep,
	volume,
	sep,
	date,
	sep,
	layout,
	sep,
	battery,
	sep,
	storage,
}

-------------------------------------------------------------------------------
-- Basic Settings
-------------------------------------------------------------------------------

oxwm.set_terminal(terminal)
oxwm.set_modkey(modkey) -- Used for Mod + mouse binds (drag/resize)
oxwm.set_tags(tags)

-------------------------------------------------------------------------------
-- Appearance
-------------------------------------------------------------------------------

-- Border
oxwm.border.set_width(0)
oxwm.border.set_focused_color(colors.purple)
oxwm.border.set_unfocused_color(colors.sep)

-- Gaps (Smart = no border when only 1 window)
oxwm.gaps.set_smart(true)
oxwm.gaps.set_inner(25, 20) -- (horizontal, vertical) in pixels
oxwm.gaps.set_outer(25, 20) -- (horizontal, vertical) in pixels

-------------------------------------------------------------------------------
-- Layouts
-------------------------------------------------------------------------------
-- Available: "tiling", "normie" (floating), "grid", "monocle", "tabbed"

oxwm.set_layout_symbol("tiling", "[T]")
oxwm.set_layout_symbol("normie", "[F]")
oxwm.set_layout_symbol("tabbed", "[=]")
oxwm.set_layout_symbol("monocle", "[M]")
oxwm.set_layout_symbol("grid", "[G]")

-------------------------------------------------------------------------------
-- Window Rules
-------------------------------------------------------------------------------

oxwm.rule.add({ instance = "kitty", tag = 1 })
oxwm.rule.add({ instance = "brave-browser", tag = 2 })
oxwm.rule.add({ instance = "connect", floating = true })
oxwm.rule.add({ instance = "connect", tag = 6 })
oxwm.rule.add({ instance = "gimp", floating = true })
oxwm.rule.add({ instance = "libreoffice-writer", tag = 6 })
oxwm.rule.add({ instance = "libreoffice-calc", tag = 6 })
oxwm.rule.add({ instance = "libreoffice", tag = 6 })
oxwm.rule.add({ instance = "Telegram", tag = 5 })
oxwm.rule.add({ instance = "thunar", tag = 9 })
oxwm.rule.add({ instance = "vlc", tag = 3 })

-------------------------------------------------------------------------------
-- Status Bar
-------------------------------------------------------------------------------

oxwm.bar.set_font(bar_font)
oxwm.bar.set_blocks(blocks)

-- Color schemes for workspace tags (foreground, background, border)
oxwm.bar.set_scheme_normal(colors.fg, colors.bg, "#444444") -- Unoccupied
oxwm.bar.set_scheme_occupied(colors.cyan, colors.bg, colors.cyan) -- Occupied
oxwm.bar.set_scheme_selected(colors.cyan, colors.bg, colors.purple) -- Selected

-------------------------------------------------------------------------------
-- Keybindings
-------------------------------------------------------------------------------

-- Apps
oxwm.key.bind({ modkey, "Shift" }, "T", oxwm.spawn(alt_term))
oxwm.key.bind({ modkey }, "Q", oxwm.spawn_terminal())
oxwm.key.bind({ modkey }, "D", oxwm.spawn({ "sh", "-c", "rofi -show drun" }))
oxwm.key.bind({ modkey, "Shift" }, "D", oxwm.spawn({ "sh", "-c", "dmenu_run -l 10" }))
oxwm.key.bind({ modkey, "Shift" }, "B", oxwm.spawn({ "st blueman-manager" }))
oxwm.key.bind({ modkey }, "B", oxwm.spawn({ "brave" }))
oxwm.key.bind({}, "Print", oxwm.spawn({ "flameshot gui" }))
oxwm.key.bind({ modkey }, "E", oxwm.spawn({ "thunar" }))

-- Window management
oxwm.key.bind({ modkey, "Shift" }, "L", oxwm.spawn({ "betterlockscreen -l" }))
oxwm.key.bind({ modkey }, "C", oxwm.client.kill())
oxwm.key.bind({ modkey, "Shift" }, "F", oxwm.client.toggle_fullscreen())
oxwm.key.bind({ modkey, "Shift" }, "Space", oxwm.client.toggle_floating())
oxwm.key.bind({ modkey }, "J", oxwm.client.focus_stack(1)) -- Focus up stack
oxwm.key.bind({ modkey }, "K", oxwm.client.focus_stack(-1)) -- Focus down stack
oxwm.key.bind({ modkey, "Shift" }, "J", oxwm.client.move_stack(1)) -- Move up stack
oxwm.key.bind({ modkey, "Shift" }, "K", oxwm.client.move_stack(-1)) -- Move down stack

-- Layout
oxwm.key.bind({ modkey }, "T", oxwm.layout.set("tiling"))
oxwm.key.bind({ modkey }, "N", oxwm.layout.cycle())
oxwm.key.bind({ modkey }, "S", oxwm.layout.scroll_left())
oxwm.key.bind({ modkey, "Shift" }, "S", oxwm.layout.scroll_right())

-- Master area (tiling)
oxwm.key.bind({ modkey }, "H", oxwm.set_master_factor(-5)) -- Shrink master
oxwm.key.bind({ modkey }, "L", oxwm.set_master_factor(5)) -- Grow master
oxwm.key.bind({ modkey }, "I", oxwm.inc_num_master(1)) -- More masters
oxwm.key.bind({ modkey }, "P", oxwm.inc_num_master(-1)) -- Fewer masters

-- Gaps
oxwm.key.bind({ modkey }, "A", oxwm.toggle_gaps())

-- WM controls
oxwm.key.bind({ modkey, "Shift" }, "Q", oxwm.quit())
oxwm.key.bind({ modkey, "Shift" }, "R", oxwm.restart())
oxwm.key.bind({ modkey, "Shift" }, "Slash", oxwm.show_keybinds())

-- Multi-monitor
oxwm.key.bind({ modkey }, "Comma", oxwm.monitor.focus(-1)) -- Focus prev monitor
oxwm.key.bind({ modkey }, "Period", oxwm.monitor.focus(1)) -- Focus next monitor
oxwm.key.bind({ modkey, "Shift" }, "Comma", oxwm.monitor.tag(-1)) -- Move win to prev monitor
oxwm.key.bind({ modkey, "Shift" }, "Period", oxwm.monitor.tag(1)) -- Move win to next monitor

-- Workspace navigation (tags are 0-indexed)
oxwm.key.bind({ modkey }, "1", oxwm.tag.view(0))
oxwm.key.bind({ modkey }, "2", oxwm.tag.view(1))
oxwm.key.bind({ modkey }, "3", oxwm.tag.view(2))
oxwm.key.bind({ modkey }, "4", oxwm.tag.view(3))
oxwm.key.bind({ modkey }, "5", oxwm.tag.view(4))
oxwm.key.bind({ modkey }, "6", oxwm.tag.view(5))
oxwm.key.bind({ modkey }, "7", oxwm.tag.view(6))
oxwm.key.bind({ modkey }, "8", oxwm.tag.view(7))
oxwm.key.bind({ modkey }, "9", oxwm.tag.view(8))

-- Move window to workspace
oxwm.key.bind({ modkey, "Shift" }, "1", oxwm.tag.move_to(0))
oxwm.key.bind({ modkey, "Shift" }, "2", oxwm.tag.move_to(1))
oxwm.key.bind({ modkey, "Shift" }, "3", oxwm.tag.move_to(2))
oxwm.key.bind({ modkey, "Shift" }, "4", oxwm.tag.move_to(3))
oxwm.key.bind({ modkey, "Shift" }, "5", oxwm.tag.move_to(4))
oxwm.key.bind({ modkey, "Shift" }, "6", oxwm.tag.move_to(5))
oxwm.key.bind({ modkey, "Shift" }, "7", oxwm.tag.move_to(6))
oxwm.key.bind({ modkey, "Shift" }, "8", oxwm.tag.move_to(7))
oxwm.key.bind({ modkey, "Shift" }, "9", oxwm.tag.move_to(8))

-- Combo view: show multiple tags at once (e.g. Mod+Ctrl+2 while on tag 1 = show both)
oxwm.key.bind({ modkey, "Control" }, "1", oxwm.tag.toggleview(0))
oxwm.key.bind({ modkey, "Control" }, "2", oxwm.tag.toggleview(1))
oxwm.key.bind({ modkey, "Control" }, "3", oxwm.tag.toggleview(2))
oxwm.key.bind({ modkey, "Control" }, "4", oxwm.tag.toggleview(3))
oxwm.key.bind({ modkey, "Control" }, "5", oxwm.tag.toggleview(4))
oxwm.key.bind({ modkey, "Control" }, "6", oxwm.tag.toggleview(5))
oxwm.key.bind({ modkey, "Control" }, "7", oxwm.tag.toggleview(6))
oxwm.key.bind({ modkey, "Control" }, "8", oxwm.tag.toggleview(7))
oxwm.key.bind({ modkey, "Control" }, "9", oxwm.tag.toggleview(8))

-- Multi-tag: pin window to multiple tags (e.g. Mod+Ctrl+Shift+2 = current tag + tag 2)
oxwm.key.bind({ modkey, "Control", "Shift" }, "1", oxwm.tag.toggletag(0))
oxwm.key.bind({ modkey, "Control", "Shift" }, "2", oxwm.tag.toggletag(1))
oxwm.key.bind({ modkey, "Control", "Shift" }, "3", oxwm.tag.toggletag(2))
oxwm.key.bind({ modkey, "Control", "Shift" }, "4", oxwm.tag.toggletag(3))
oxwm.key.bind({ modkey, "Control", "Shift" }, "5", oxwm.tag.toggletag(4))
oxwm.key.bind({ modkey, "Control", "Shift" }, "6", oxwm.tag.toggletag(5))
oxwm.key.bind({ modkey, "Control", "Shift" }, "7", oxwm.tag.toggletag(6))
oxwm.key.bind({ modkey, "Control", "Shift" }, "8", oxwm.tag.toggletag(7))
oxwm.key.bind({ modkey, "Control", "Shift" }, "9", oxwm.tag.toggletag(8))

-- Media controls (PipeWire/WirePlumber + playerctl)
oxwm.key.bind({}, "XF86AudioRaiseVolume", oxwm.spawn({ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+" }))
oxwm.key.bind({}, "XF86AudioLowerVolume", oxwm.spawn({ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" }))
oxwm.key.bind({}, "XF86AudioMute", oxwm.spawn({ "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" }))
oxwm.key.bind({}, "XF86AudioPlay", oxwm.spawn({ "playerctl play-pause" }))
oxwm.key.bind({}, "XF86AudioStop", oxwm.spawn({ "playerctl stop" }))
oxwm.key.bind({}, "XF86AudioNext", oxwm.spawn({ "playerctl next" }))
oxwm.key.bind({}, "XF86AudioPrev", oxwm.spawn({ "playerctl previous" }))

-------------------------------------------------------------------------------
-- Keychords
-------------------------------------------------------------------------------

oxwm.key.chord({
	{ { modkey }, "Space" },
	{ {}, "W" },
}, oxwm.spawn({ "wallmenu" }))

oxwm.key.chord({
	{ { modkey }, "Space" },
	{ {}, "C" },
}, oxwm.spawn({ "kitty --class connect -e nmtui" }))
-------------------------------------------------------------------------------
-- Autostart
-------------------------------------------------------------------------------

oxwm.autostart("xset r rate 200 35")
oxwm.autostart("picom")
oxwm.autostart("xwallpaper --zoom ~/.local/share/current_wallpaper")
oxwm.autostart("dunst")
oxwm.autostart("xss-lock -- betterlockscreen -l")
oxwm.autostart("kitty")
