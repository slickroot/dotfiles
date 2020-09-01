---------------------------
-- Elaich awesome theme --
---------------------------
local gears = require("gears")
local beautiful = require("beautiful")
local xrdb = beautiful.xresources.get_current_theme()

local theme = {}

theme.wallpaper = "~/.config/awesome/themes/default/background.png"

-- Gaps
theme.screen_margin = dpi(15)
theme.useless_gap   = dpi(15)

-- Wibar
theme.wibar_height = 50
theme.wibar_width = 1600
theme.wibar_bg = gears.color.transparent
theme.wibar_bg = xrdb.background

-- Notifications
theme.notification_bg = xrdb.background.."00"
theme.notification_fg = xrdb.foreground
theme.notification_margin = dpi(15)
theme.notification_title_font = "sans 14"
theme.notification_icon_size = dpi(60)
theme.notification_font = "sans 12"
theme.notification_border_width = dpi(0)
theme.notification_spacing = dpi(15)

-- Font
theme.font = "sans"

return theme
