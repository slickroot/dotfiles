local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local textbox = require("wibox.widget.textbox")
local naughty = require("naughty")
local xrdb = beautiful.xresources.get_current_theme()
local ruled = require("ruled")
local slick = require("slick")

ruled.notification.connect_signal('request::rules', function()
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
    -- Default icon
    ruled.notification.append_rule {
        rule        = { urgency = 'normal' },
        properties  = { icon = "", icon_color = xrdb.color8 }
    }

	-- notifications from google calendar
    ruled.notification.append_rule {
        rule        = { message = 'calendar.google.com' },
        properties  = { icon = "", icon_color = xrdb.color2, message = 'From calendar' }
    }

    -- notifications icon rules
    ruled.notification.append_rule {
        rule        = { app_name = 'battery' },
        properties  = { icon = "" , icon_color = xrdb.color9 }
    }

    -- notifications icon rules
    ruled.notification.append_rule {
        rule        = { app_name = 'screenshot' },
        properties  = { icon = "", icon_color = xrdb.color2 }
    }
end)

-- shortcut
local icon_size = beautiful.notification_icon_size

local build_notification_box = function(n)
    local margin = beautiful.notification_margin
    local padding = 10


	local actions_template = {
		{
			{
				{
					id = "text_role",
					font = beautiful.notification_font,
					widget = textbox
				},
				widget = wibox.container.place
			},
			margins = {
				top = dpi(5),
				bottom = dpi(5),
				left = dpi(10),
				right = dpi(10)
			},
			widget = wibox.container.margin
		},
		bg = xrdb.color8 .. "32",
		widget = wibox.container.background
	}

	local actions = wibox.widget{
		notification = n,
		base_layout = wibox.widget{
			spacing = 5,
			layout = wibox.layout.flex.horizontal
		},
		widget_template = actions_template,
		style = {
			underline_normal = false,
			underline_selected = true
		},
		widget = naughty.list.actions
	}

	local notification_title = {
		markup = "<b>" .. n.title .. "</b>",
		font = beautiful.notification_title_font,
		widget = textbox
	}

	local notification_message = {
		align = "left",
		widget = naughty.widget.message
	}

	local notification_actions = {
		actions,
		top = dpi(10),
		widget = wibox.container.margin
	}

    local notification_box = naughty.layout.box{
        notification = n,
        type = "dock",
        widget_template = {
            {
                {
                    {
                        notification_title,
                        notification_message,
                        notification_actions,
                        spacing = dpi(8),
                        layout = wibox.layout.fixed.vertical
                    },
                    margins = { bottom = margin, top = margin, right = margin },
                    left = 2 * margin / 3 + icon_size / 2,
                    widget = wibox.container.margin
                },
                shape = slick.shapes.notification(icon_size, margin),
                bg = xrdb.color0,
                widget = wibox.container.background
            },
            strategy = "max",
            width = dpi(500),
            height = dpi(80),
            widget = wibox.container.constraint
        }
    }

	return notification_box
end

local build_notification_icon = function(n)
	local notification_icon_widget = {
		{
			{
				markup = '<span color="' .. n.icon_color .. '">'.. n.icon ..'</span>',
				align = "center",
				font = beautiful.notification_icon_font,
				widget = textbox
			},
			bg = xrdb.background,
			forced_width = icon_size,
			forced_height = icon_size,
			shape = gears.shape.circle,
			widget = wibox.container.background
		},
		halign = "center",
		widget = wibox.container.place
	}

	local notification_icon = awful.popup{
		ontop = true,
		height = icon_size,
		width = icon_size,
		bg = "#00000000",
		visible = true,
		type = "dock",
		widget = notification_icon_widget
	}

	return notification_icon
end

naughty.connect_signal("request::display", function(n)
	local notification_box = build_notification_box(n)
	local notification_icon = build_notification_icon(n)

	-- place icon at the left of the notification box
	awful.placement.left(notification_icon, {
		parent = notification_box,
        attach = true,
		offset = { x = - icon_size / 2 }
	})

	n:connect_signal("destroyed", function()
		notification_icon.visible = false
	end)
end)
