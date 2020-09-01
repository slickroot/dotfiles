local beautiful = require("beautiful")

local shapes = {}

function shapes.notification(icon_size, radius)
    return function (cr, width, height)
        cr:line_to(width - radius, 0)
        cr:arc(width - radius, radius, radius, 3*math.pi/2, 2*math.pi)
        cr:line_to(width, height - radius)
        cr:arc(width - radius, height - radius, radius, 0, math.pi/2)
        cr:line_to(0, height)
        cr:line_to(0, (height - icon_size) / 2)
        cr:arc_negative(0, height / 2, icon_size / 2 + 4, math.pi/2, 3*math.pi/2)
        cr:line_to(0, 0)
    end
end

return shapes
