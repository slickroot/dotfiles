-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local naughty = require("naughty")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
dpi = beautiful.xresources.apply_dpi

require("awful.hotkeys_popup.keys")

-- Variable definitions
-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/themes/default/theme.lua")



-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)
    awful.tag.add("1", {
            layout             = awful.layout.suit.max,
            master_fill_policy = "master_width_factor",
            gap_single_client  = true,
            gap                = 20,
            screen             = s,
            selected           = true,
        })
    awful.tag.add("2", {
            layout = awful.layout.suit.tile,
            screen = s
        })
    awful.tag.add("3", {
            layout = awful.layout.suit.tile,
            screen = s
        })
    awful.tag.add("4", {
            layout = awful.layout.suit.floating,
            screen = s
        })
end)

require("keys")
require("rules")
require("signals")
-- notifications
require("bells")

awful.spawn.with_line_callback('dbusbattery', {
    stdout = function(line)
		percentage = tonumber(line)
		if percentage < 15 then 
			naughty.notification { title = "Attention!", message = "Battery level is " .. line, app_name = "battery", timeout = 0 } 
		end
    end
})
awful.spawn.with_shell("picom")
