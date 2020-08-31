local awful = require("awful")

local tagnames = function(s) 
    awful.tag.add("1", {
        layout             = awful.layout.suit.float,
        screen             = s,
        selected           = true,
    })

    awful.tag.add("2", {
        layout = awful.layout.suit.max,
        gap_single_client  = true,
        gap                = 25,
        screen = s,
    })

    awful.tag.add("3", {
        layout = awful.layout.suit.max,
        gap_single_client  = true,
        gap                = 25,
        screen = s,
    })
    awful.tag.add("4", {
        layout = awful.layout.suit.max,
        gap_single_client  = true,
        gap                = 25,
        screen = s,
    })
end

return tagnames
