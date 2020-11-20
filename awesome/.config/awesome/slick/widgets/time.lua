local wibox = require('wibox')

local format = '| %H:%M |'
local clock = wibox.widget.textclock('<span foreground="#fee17f">'..format..'</span>')
return clock
