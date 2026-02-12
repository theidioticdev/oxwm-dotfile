---@meta

------------------------------------
---         OXWM Config         ----
------------------------------------

---@module 'oxwm'

-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------
-- Modifier key: "Mod4" is the Super/Windows key, "Mod1" is Alt
local modkey = "Mod4"

local terminal = "kitty"

local theme_name = "nord"

local colors = require(theme_name)
-- Workspace tags
local tags = { "", "󰊯", "󰕼", "", "󰙯", "󱇤", "", "󰊴", "" }

-- Font for the status bar (use "fc-list" to see available fonts)
local bar_font = "JetBrainsMono Nerd Font Propo:style=Bold:size=12"

-- Status bar block

local blocks = {
	oxwm.bar.block.shell({
		format = " {}",
		command = "uname -r",
		interval = 999999999,
		color = colors.red,
		underline = true,
	}),
	oxwm.bar.block.static({
		text = " │  ",
		interval = 999999999,
		color = colors.sep,
		underline = false,
	}),
	oxwm.bar.block.ram({
		format = "󰍛 Ram: {used}/{total} GB",
		interval = 5,
		color = colors.light_blue,
		underline = true,
	}),
	oxwm.bar.block.static({
		text = " │  ",
		interval = 999999999,
		color = colors.sep,
		underline = false,
	}),
	oxwm.bar.block.datetime({
		format = "󰸘 {}",
		date_format = "%a, %b %d - %-I:%M %P",
		interval = 1,
		color = colors.cyan,
		underline = true,
	}),
	oxwm.bar.block.static({
		text = " │  ",
		interval = 999999999,
		color = colors.sep,
		underline = false,
	}),
	oxwm.bar.block.battery({
		format = "󰁹 {}%",
		charging = "⚡󰁹 {}%",
		discharging = "-󰁹 {}%",
		full = "✓󰁹 {}%",
		interval = 10,
		color = colors.green,
		underline = true,
	}),

	oxwm.bar.block.static({
		text = " │  ",
		interval = 999999999,
		color = colors.sep,
		underline = false,
	}),
	oxwm.bar.block.shell({
		format = "󰕾 {}",
		command = "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100 \"%\"}'",
		interval = 0.5,
		color = colors.purple,
		underline = true,
	}),
	oxwm.bar.block.static({
		text = " │  ",
		interval = 999999999,
		color = colors.sep,
		underline = false,
	}),
	oxwm.bar.block.shell({
		format = "  {}",
		command = "setxkbmap -query | awk '/layout/ {print $2}'",
		interval = 0.5,
		color = colors.cyan,
		underline = true,
	}),
}

-------------------------------------------------------------------------------
-- Basic Settings
-------------------------------------------------------------------------------
oxwm.set_terminal(terminal)
oxwm.set_modkey(modkey) -- This is for Mod + mouse binds, such as drag/resize
oxwm.set_tags(tags)
-- Border configuration

-------------------------------------------------------------------------------
-- Layouts
-------------------------------------------------------------------------------
-- Set custom symbols for layouts (displayed in the status bar)
-- Available layouts: "tiling", "normie" (floating), "grid", "monocle", "tabbed"
oxwm.set_layout_symbol("tiling", "[T]")
oxwm.set_layout_symbol("normie", "[F]")
oxwm.set_layout_symbol("tabbed", "[=]")
oxwm.set_layout_symbol("monocle", "[M]")
oxwm.set_layout_symbol("grid", "[G]")
-------------------------------------------------------------------------------
-- Appearance
-------------------------------------------------------------------------------
-- Border configuration

-- Width in pixels
oxwm.border.set_width(2)
-- Color of focused window border
oxwm.border.set_focused_color(colors.blue)
-- Color of unfocused window borders
oxwm.border.set_unfocused_color(colors.sep)

-- Smart Enabled = No border if 1 window
oxwm.gaps.set_smart(false)
-- Inner gaps (horizontal, vertical) in pixels
oxwm.gaps.set_inner(25, 25)
-- Outer gaps (horizontal, vertical) in pixels
oxwm.gaps.set_outer(25, 25)

-------------------------------------------------------------------------------
-- Window Rules
-------------------------------------------------------------------------------
oxwm.rule.add({ instance = "gimp", floating = true })
oxwm.rule.add({ instance = "brave-browser", tag = 2 })
oxwm.rule.add({ instance = "kitty", tag = 1 })
oxwm.rule.add({ instance = "thunar", tag = 9 })
oxwm.rule.add({ instance = "blueman-manager", floating = true })
oxwm.rule.add({ instance = "vlc", tag = 3 })
-------------------------------------------------------------------------------
-- Status Bar Configuration
-------------------------------------------------------------------------------
-- Font configuration
oxwm.bar.set_font(bar_font)

-- Set your blocks here (defined above)
oxwm.bar.set_blocks(blocks)

-- Bar color schemes (for workspace tag display)
-- Parameters: foreground, background, border

-- Unoccupied tags
oxwm.bar.set_scheme_normal(colors.fg, colors.bg, "#444444")
-- Occupied tags
oxwm.bar.set_scheme_occupied(colors.cyan, colors.bg, colors.cyan)
-- Currently selected tag
oxwm.bar.set_scheme_selected(colors.cyan, colors.bg, colors.purple)

-------------------------------------------------------------------------------
-- Keybindings
-------------------------------------------------------------------------------
--  Basic binds
oxwm.key.bind({ modkey }, "V", oxwm.spawn({ "vlc" }))
oxwm.key.bind({ modkey }, "B", oxwm.spawn({ "blueman-manager" }))
oxwm.key.bind({ modkey }, "S", oxwm.spawn({ "flameshot gui" }))
oxwm.key.bind({ modkey }, "Q", oxwm.spawn_terminal())
-- oxwm.key.bind({ modkey }, "D", oxwm.spawn({ "sh", "-c", "dmenu_run -l 10" }))
oxwm.key.bind({ modkey }, "D", oxwm.spawn({ "sh", "-c", "rofi -show drun" }))
oxwm.key.bind({ modkey }, "C", oxwm.client.kill())

-- Keybind overlay - Shows important keybindings on screen
oxwm.key.bind({ modkey, "Shift" }, "Slash", oxwm.show_keybinds())

-- Window state toggles
oxwm.key.bind({ modkey, "Shift" }, "F", oxwm.client.toggle_fullscreen())
oxwm.key.bind({ modkey, "Shift" }, "Space", oxwm.client.toggle_floating())

-- Layout management
oxwm.key.bind({ modkey }, "T", oxwm.layout.set("tiling"))
-- Cycle through layouts
oxwm.key.bind({ modkey }, "N", oxwm.layout.cycle())

-- Master area controls (tiling layout)

-- Decrease/Increase master area width
oxwm.key.bind({ modkey }, "H", oxwm.set_master_factor(-5))
oxwm.key.bind({ modkey }, "L", oxwm.set_master_factor(5))
-- Increment/Decrement number of master windows
oxwm.key.bind({ modkey }, "I", oxwm.inc_num_master(1))
oxwm.key.bind({ modkey }, "P", oxwm.inc_num_master(-1))

-- Gaps toggle
oxwm.key.bind({ modkey }, "A", oxwm.toggle_gaps())

-- Window manager controls
oxwm.key.bind({ modkey, "Shift" }, "Q", oxwm.quit())
oxwm.key.bind({ modkey, "Shift" }, "R", oxwm.restart())

-- Focus movement [1 for up in the stack, -1 for down]
oxwm.key.bind({ modkey }, "J", oxwm.client.focus_stack(1))
oxwm.key.bind({ modkey }, "K", oxwm.client.focus_stack(-1))

-- Window movement (swap position in stack)
oxwm.key.bind({ modkey, "Shift" }, "J", oxwm.client.move_stack(1))
oxwm.key.bind({ modkey, "Shift" }, "K", oxwm.client.move_stack(-1))

-- Multi-monitor support

-- Focus next/previous Monitors
oxwm.key.bind({ modkey }, "Comma", oxwm.monitor.focus(-1))
oxwm.key.bind({ modkey }, "Period", oxwm.monitor.focus(1))
-- Move window to next/previous Monitors
oxwm.key.bind({ modkey, "Shift" }, "Comma", oxwm.monitor.tag(-1))
oxwm.key.bind({ modkey, "Shift" }, "Period", oxwm.monitor.tag(1))

-- Workspace (tag) navigation
-- Switch to workspace N (tags are 0-indexed, so tag "1" is index 0)
oxwm.key.bind({ modkey }, "1", oxwm.tag.view(0))
oxwm.key.bind({ modkey }, "2", oxwm.tag.view(1))
oxwm.key.bind({ modkey }, "3", oxwm.tag.view(2))
oxwm.key.bind({ modkey }, "4", oxwm.tag.view(3))
oxwm.key.bind({ modkey }, "5", oxwm.tag.view(4))
oxwm.key.bind({ modkey }, "6", oxwm.tag.view(5))
oxwm.key.bind({ modkey }, "7", oxwm.tag.view(6))
oxwm.key.bind({ modkey }, "8", oxwm.tag.view(7))
oxwm.key.bind({ modkey }, "9", oxwm.tag.view(8))

-- Move focused window to workspace N
oxwm.key.bind({ modkey, "Shift" }, "1", oxwm.tag.move_to(0))
oxwm.key.bind({ modkey, "Shift" }, "2", oxwm.tag.move_to(1))
oxwm.key.bind({ modkey, "Shift" }, "3", oxwm.tag.move_to(2))
oxwm.key.bind({ modkey, "Shift" }, "4", oxwm.tag.move_to(3))
oxwm.key.bind({ modkey, "Shift" }, "5", oxwm.tag.move_to(4))
oxwm.key.bind({ modkey, "Shift" }, "6", oxwm.tag.move_to(5))
oxwm.key.bind({ modkey, "Shift" }, "7", oxwm.tag.move_to(6))
oxwm.key.bind({ modkey, "Shift" }, "8", oxwm.tag.move_to(7))
oxwm.key.bind({ modkey, "Shift" }, "9", oxwm.tag.move_to(8))

-- Combo view (view multiple tags at once) {argos_nothing}
-- Example: Mod+Ctrl+2 while on tag 1 will show BOTH tags 1 and 2
oxwm.key.bind({ modkey, "Control" }, "1", oxwm.tag.toggleview(0))
oxwm.key.bind({ modkey, "Control" }, "2", oxwm.tag.toggleview(1))
oxwm.key.bind({ modkey, "Control" }, "3", oxwm.tag.toggleview(2))
oxwm.key.bind({ modkey, "Control" }, "4", oxwm.tag.toggleview(3))
oxwm.key.bind({ modkey, "Control" }, "5", oxwm.tag.toggleview(4))
oxwm.key.bind({ modkey, "Control" }, "6", oxwm.tag.toggleview(5))
oxwm.key.bind({ modkey, "Control" }, "7", oxwm.tag.toggleview(6))
oxwm.key.bind({ modkey, "Control" }, "8", oxwm.tag.toggleview(7))
oxwm.key.bind({ modkey, "Control" }, "9", oxwm.tag.toggleview(8))

-- Multi tag (window on multiple tags)
-- Example: Mod+Ctrl+Shift+2 puts focused window on BOTH current tag and tag 2
oxwm.key.bind({ modkey, "Control", "Shift" }, "1", oxwm.tag.toggletag(0))
oxwm.key.bind({ modkey, "Control", "Shift" }, "2", oxwm.tag.toggletag(1))
oxwm.key.bind({ modkey, "Control", "Shift" }, "3", oxwm.tag.toggletag(2))
oxwm.key.bind({ modkey, "Control", "Shift" }, "4", oxwm.tag.toggletag(3))
oxwm.key.bind({ modkey, "Control", "Shift" }, "5", oxwm.tag.toggletag(4))
oxwm.key.bind({ modkey, "Control", "Shift" }, "6", oxwm.tag.toggletag(5))
oxwm.key.bind({ modkey, "Control", "Shift" }, "7", oxwm.tag.toggletag(6))
oxwm.key.bind({ modkey, "Control", "Shift" }, "8", oxwm.tag.toggletag(7))
oxwm.key.bind({ modkey, "Control", "Shift" }, "9", oxwm.tag.toggletag(8))

-------------------------------------------------------------------------------
---             Media Controls (PipeWire/WirePlumber)                       ---
-------------------------------------------------------------------------------

-- Volume Up
oxwm.key.bind({}, "XF86AudioRaiseVolume", oxwm.spawn({ "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+" }))

-- Volume Down
oxwm.key.bind({}, "XF86AudioLowerVolume", oxwm.spawn({ "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-" }))

-- Mute
oxwm.key.bind({}, "XF86AudioMute", oxwm.spawn({ "wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle" }))

-- Play/Pause
oxwm.key.bind({}, "XF86AudioPlay", oxwm.spawn({ "playerctl", "play-pause" }))

-- Stop
oxwm.key.bind({}, "XF86AudioStop", oxwm.spawn({ "playerctl", "stop" }))

-- Next/Previous (Optional but handy)
oxwm.key.bind({}, "XF86AudioNext", oxwm.spawn({ "playerctl", "next" }))
oxwm.key.bind({}, "XF86AudioPrev", oxwm.spawn({ "playerctl", "previous" }))

-------------------------------------------------------------------------------
-- Keychords
-------------------------------------------------------------------------------
-- Format: {{modifiers}, key1}, {{modifiers}, key2}, ...
oxwm.key.chord({
	{ { modkey }, "Space" },
	{ {}, "B" },
}, oxwm.spawn({ "brave" }))

oxwm.key.chord({
	{ { modkey }, "Space" },
	{ {}, "G" },
}, oxwm.spawn({ "gimp" }))

oxwm.key.chord({
	{ { modkey }, "Space" },
	{ {}, "C" },
}, oxwm.spawn({ "kitty --class connect -e nmtui-connect" }))

oxwm.key.chord({
	{ { modkey }, "Space" },
	{ {}, "E" },
}, oxwm.spawn({ "thunar" }))

oxwm.key.chord({
	{ { modkey }, "Space" },
	{ {}, "M" },
}, oxwm.spawn({ "poweroff" }))

oxwm.key.chord({
	{ { modkey }, "Space" },
	{ {}, "L" },
}, oxwm.spawn({ "i3lock" }))

oxwm.key.chord({
	{ { modkey }, "Space" },
	{ {}, "W" },
}, oxwm.spawn({ "wallmenu" }))
-------------------------------------------------------------------------------
-- Autostart
-------------------------------------------------------------------------------
-- Commands to run once when OXWM starts
-- Uncomment and modify these examples, or add your own

-- oxwm.autostart("picom")
oxwm.autostart("dunst")
oxwm.autostart("nm-applet")
oxwm.autostart("setxkbmap -option ''")
oxwm.autostart("setxkbmap -layout us,eg -option 'grp:alt_shift_toggle'")
oxwm.autostart("xss-lock -- i3lock")
