local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local abutton = require("awful.button")
local gtable = require("gears.table")
local menubar = require("menubar")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local textbox = require("wibox.widget.textbox")
local naughty = require("naughty")
local xrdb = beautiful.xresources.get_current_theme()

local build_notification_box = function(n)
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
		align = "center",
		widget = naughty.widget.message
	}

	local notification_actions = {
		actions,
		top = dpi(10),
		widget = wibox.container.margin
	}

	local notification_box = naughty.layout.box{
		notification = n,
		offset = { x = dpi(5) },
		type = "notification",
		widget_template = {
			{
				{
					notification_title,
					notification_message,
					notification_actions,
					layout = wibox.layout.align.vertical
				},
				margins = {
					top = beautiful.notification_margin,
					bottom = beautiful.notification_margin,
					right = beautiful.notification_margin,
					left = beautiful.notification_margin / 2 + dpi(30)
				},
				widget = wibox.container.margin
			},
			bg = xrdb.background .. "EE",
			widget = wibox.container.background
		}
	}

	return notification_box
end

local build_notification_icon = function(n)
	local notification_icon_widget = {
		{
			{
				markup = '<span color="' .. xrdb.color2 .. '"></span>',
				align = "center",
				font = "awesome 16",
				widget = textbox
			},
			bg = xrdb.background,
			forced_width = dpi(60),
			forced_height = dpi(60),
			shape = gears.shape.circle,
			widget = wibox.container.background
		},
		halign = "center",
		widget = wibox.container.place
	}

	local notification_icon = awful.popup{
		ontop = true,
		height = dpi(60),
		width = dpi(60),
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
		offset = { x = -dpi(30) }
	})

	n:connect_signal("destroyed", function()
		notification_icon.visible = false
	end)
end)
