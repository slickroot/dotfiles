local wibox = require('wibox')
local gears = require('gears')
local awful = require('awful')
local slick = require('slick.container')
local beautiful = require("beautiful")
local xrdb = beautiful.xresources.get_current_theme()
local cairo = require("lgi").cairo
-- CAIRO_LINE_CAP_ROUND

local background = xrdb.background

local percentage = 14

local MAX_HEIGHT = dpi(100)

local battery_height = percentage * MAX_HEIGHT / 100

local eye = wibox.widget {
    forced_height = dpi(5),
    forced_width = dpi(10),
    shape = function(cr, width, height)
        cr:move_to(0,0)
        gears.shape.rounded_rect(cr, width, height, 7)
    end,
    bg = background,
    widget = wibox.container.background()
}

-- draw hangry mouth
local d_hungry = function(cr, width, height)
    cr:set_source(gears.color(background))
    cr:set_line_width(dpi(4))
    cr:set_line_cap(cairo.LineCap.ROUND)
    cr:move_to(dpi(4), height - dpi(4))
    cr:curve_to(
        dpi(4), dpi(8),
        width - dpi(4), dpi(8),
        width - dpi(4), height - dpi(4)
        )
    cr:stroke()
    cr:arc(width - dpi(4), height - dpi(4), dpi(3), 0, 2*math.pi)
    cr:fill()
end

-- draw happy mouth
local d_happy = function(cr, width, height)
    cr:set_source_rgb(0, 0, 0) -- Red
    cr:set_line_width(dpi(4))
    cr:set_line_cap(cairo.LineCap.ROUND)
    cr:move_to(dpi(4), dpi(4))
    cr:curve_to(
        dpi(4), height - dpi(4),
        width - dpi(4), height - dpi(4),
        width - dpi(4), dpi(4)
        )
    cr:scale(0.8, 0.8)
    cr:stroke()
end

-- draw normal mouth
local d_normal = function(cr, width, height)
    cr:set_source(gears.color(background))
    cr:set_line_width(dpi(4))
    cr:set_line_cap(cairo.LineCap.ROUND)
    cr:move_to(dpi(4), dpi(4))
    cr:curve_to(
        dpi(4), dpi(12),
        width - dpi(4), dpi(12),
        width - dpi(4), dpi(4)
        )
    cr:stroke()
end

local mouth_shape = d_happy
local battery_color = xrdb.color2.."BB"
if percentage < 15 then
    mouth_shape = d_hungry
    battery_color = xrdb.color1.."BB"
elseif percentage < 45 then
    mouth_shape = d_normal
    battery_color = xrdb.color4.."BB"
end


local mouth = {
    fit    = function(self, context, width, height)
        return dpi(20), dpi(20) -- A square taking the full height
    end,
    draw   = function(self, context, cr, width, height)
        mouth_shape(cr, width, height)
    end,
    layout = wibox.widget.base.make_widget,
}

local face = wibox.widget {
    {
        eye,
        valign = "top",
        widget = wibox.container.place
    },
    {
        mouth,
        valign = "bottom",
        widget = wibox.container.place
    },
    {
        eye,
        valign = "top",
        widget = wibox.container.place
    },
    spacing = dpi(0),
    forced_height = dpi(30),
    layout = wibox.layout.fixed.horizontal
}

local battery_widget = {
    {
        {
            {
                {
                    {
                        {
                            {
                                shape = gears.shape.rectangle,
                                bg = battery_color,
                                forced_height = battery_height,
                                widget = wibox.container.background,
                                forced_height = battery_height,
                                forced_width = dpi(70),
                            },
                            valign = "bottom",
                            widget = wibox.container.place
                        },
                        shape = function(cr, width, height)
                            gears.shape.rounded_rect(cr, width, height, dpi(9))
                        end,
                        widget = wibox.container.background
                    },
                    margins = dpi(5),
                    widget = wibox.container.margin
                },
                {
                    {
                        face,
                        valign = "top",
                        widget = wibox.container.place
                    },
                    top = dpi(20),
                    widget = wibox.container.margin
                }, 
                layout = wibox.layout.stack
            },
            bg = xrdb.foreground.."BB",
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, dpi(9))
            end,
            widget = wibox.container.background
        }, 
        margins = {left = dpi(4), bottom = dpi(4), right = dpi(4)},
        top = dpi(13), 
        widget = wibox.container.margin
    },
    shape = function(cr, width, height)
        local r = dpi(8)
        local sr = dpi(4)
        local head = dpi(12)
        cr:move_to(0, 2 * r) 
        cr:line_to(0, height - r)
        cr:arc_negative(r, height - r, r, math.pi, math.pi/2)
        cr:line_to(width - r, height)
        cr:arc_negative(width - r, height - r, r, math.pi/2, 0)
        cr:line_to(width, 2* r)
        cr:arc_negative(width - r, r * 2, r, 0, 3*math.pi/2)
        cr:line_to(r , r )
        cr:arc_negative(r, r*2, r, 3*math.pi/2, 0)
        cr:move_to(width / 2 - head, r)
        cr:line_to(width / 2 - head, sr)
        cr:arc(width / 2 - head + sr, sr, sr, math.pi, 3*math.pi/2)
        cr:line_to(width / 2 + head - sr, 0)
        cr:arc(width / 2 + head - sr, sr, sr, 3*math.pi/2, 0)
        cr:line_to(width / 2 + head, r)
    end,
    forced_width = dpi(70),
    forced_height = dpi(120),
    bg = xrdb.foreground.."33",
    widget = wibox.container.background
}

return battery_widget
