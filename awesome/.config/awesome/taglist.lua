local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local lemon = {}
lemon["full"] = os.getenv("HOME") .. '/.config/awesome/icons/orange.svg'
lemon["empty"] = os.getenv("HOME") .. '/.config/awesome/icons/orange_empty.svg'

local taglist = function(s)
    return awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        layout   = {
            spacing = 8,
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    id     = 'icon_role',
                    widget = wibox.widget.imagebox,
                },
                margins = { top = 10, bottom = 10 },
                widget = wibox.container.margin
            },
            widget = wibox.container.background,
            -- Add support for hover colors and an index label
            create_callback = function(self, c3, index, objects) 
                if c3.selected then
                    self:get_children_by_id('icon_role')[1].image = lemon["full"]
                else
                    self:get_children_by_id('icon_role')[1].image = lemon["empty"]
                end

            end,
            update_callback = function(self, c3, index, objects) 
                if c3.selected then
                    self:get_children_by_id('icon_role')[1].image = lemon["full"]
                else
                    self:get_children_by_id('icon_role')[1].image = lemon["empty"]
                end
            end,
        },
        buttons = taglist_buttons
    }
end

return taglist
