local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local xrdb = beautiful.xresources.get_current_theme()

local capi = {
    mouse = mouse
}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Upsie, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    local maximize_button = wibox.widget {
        markup = '<span color="' .. xrdb.color6 .. '44' .. '"></span>',
        buttons = {
            awful.button({ }, 1, function()
                c.maximized = not c.maximized
            end),
        },
        font = "awesome 16",
        widget = wibox.widget.textbox
    }

    maximize_button:connect_signal('mouse::enter', function(w) 
        w.markup = '<span color="' .. xrdb.color6 .. '"></span>'
    end)

    maximize_button:connect_signal('mouse::leave', function(w) 
        w.markup = '<span color="' .. xrdb.color6 .. '44' .. '"></span>'
    end)

    local close_button = wibox.widget {
        markup = '<span color="' .. xrdb.color4 .. '44' .. '"></span>',
        buttons = {
            awful.button({ }, 1, function()
                c:kill()
            end),
        },
        font = "awesome 20",
        widget = wibox.widget.textbox
    }

    close_button:connect_signal('mouse::enter', function(w) 
        w.markup = '<span color="' .. xrdb.color4 .. '"></span>'
    end)

    close_button:connect_signal('mouse::leave', function(w) 
        w.markup = '<span color="' .. xrdb.color4 .. '44' .. '"></span>'
    end)

    awful.titlebar(c, { size = beautiful.titlebar_size }).widget = {
        {
            nil,
            {
                buttons = buttons,
                layout = wibox.layout.fixed.horizontal()
            },
            { -- Right
                maximize_button,
                close_button,
                spacing = 18,
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        },
        right = 15,
        widget = wibox.container.margin
    }
end)
