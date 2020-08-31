local wibox = require('wibox')

local battery = wibox.widget{
    markup = '<span foreground="#fee17f">90%  </span>',
    forced_height = 30,
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

return battery
