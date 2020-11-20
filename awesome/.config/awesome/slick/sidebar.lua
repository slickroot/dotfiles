local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local butler = require("slick.butler")
local slick = require("slick")
local battery = require("slick.widgets.battery")
local xrdb = beautiful.xresources.get_current_theme()

local sidebar = awful.wibar({
    ontop = true, 
    visible = true, 
    width = dpi(260),
    position = "left",
    bg = "#00000000",
    type = "dock"
})

local time = {
    format = '<span font="Slim Joe 50" foreground="'..xrdb.foreground..'">%H:%M</span>',
    widget = wibox.widget.textclock
}

local weather = {
    {
        text = "Scattered Clouds",
        align = "center",
        widget = wibox.widget.textbox
    },
    {
        {
            {
                image = '/home/slickroot/dotfiles/awesome/.config/awesome/slick/widgets/icons/weather/c02d.png',
                resize = true,
                forced_height = dpi(40),
                widget = wibox.widget.imagebox
            },
            {
                text = "19°C" ,
                align = "center",
                font = "Public Sans thin 18",
                widget = wibox.widget.textbox
            },
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        widget = wibox.container.place
    },
    layout = wibox.layout.fixed.vertical
}

local day = 24 * 60 * 60
local now = os.time()
local dow = os.date("%w")
local days_to_monday = 6 - dow
local days = {}

for i = 0,6,1 
do
    local day_time = os.time(os.date("*t",   now - 6  * day + i * day))
    local current = day_time == now
    local weekend = i > 4
    local week_day = string.sub(os.date("%a", day_time), 1, 1)
    local day_of_month = os.date("%d", day_time)
    local day_widget = {
        {
            {
                {
                    align = "center",
                    markup = weekend and butler.colorize_text(week_day, xrdb.color3) or week_day ,
                    font   = current and "Public Sans bold 10" or "Public Sans 10",
                    widget = wibox.widget.textbox
                },
                {
                    markup = weekend and butler.colorize_text(day_of_month, xrdb.color3) or day_of_month,
                    font    = current and "Public Sans bold 10" or "Public Sans 10",
                    widget = wibox.widget.textbox
                },
                spacing = dpi(5),
                layout = wibox.layout.fixed.vertical
            },
            margins = {
                top = dpi(10),
                bottom = dpi(10),
                right = dpi(5),
                left = dpi(5),
            },
            widget = wibox.container.margin
        },
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, dpi(12))
        end,
        bg = current and xrdb.color0,
        widget = wibox.container.background
    }
    table.insert(days, day_widget)
end

sidebar:setup {
    {
        {
            {
                {
                    {
                        {
                            time,
                            widget = wibox.container.place
                        },
                        widget = wibox.container.place
                    },
                    {
                        {
                            days[1],
                            days[2],
                            days[3],
                            days[4],
                            days[5],
                            days[6],
                            days[7],
                            spacing = dpi(5),
                            layout = wibox.layout.fixed.horizontal
                        },
                        widget = wibox.container.place
                    },
                    layout = wibox.layout.fixed.vertical
                },
                {
                    {
                        {
                            weather,
                            {
                                {
                                    battery,
                                    scale = { factor = 0.9 },
                                    widget = slick.container.scale
                                },
                                widget = wibox.container.place
                            },
                            fill_space = true,
                            layout = wibox.layout.fixed.vertical
                        },
                        top = dpi(20), 
                        widget = wibox.container.margin
                    },
                    bg = xrdb.color0,
                    shape = function(cr, width, height)
                        gears.shape.partially_rounded_rect(
                            cr, width, height, false, true, false, false, dpi(30)
                            )
                    end,
                    widget = wibox.container.background,
                },
                spacing = dpi(10),
                fill_space = true,
                layout = wibox.layout.fixed.vertical
            },
            top = dpi(10),
            widget = wibox.container.margin
        },
        bg = xrdb.background.."EE",
        shape = function(cr, width, height)
            gears.shape.partially_rounded_rect(
                cr, width, height, false, true, true, false, dpi(30)
                )
        end,
        widget = wibox.container.background,
    }, 
    top = dpi(120) , 
    bottom = dpi(120),
    widget = wibox.container.margin
}
