

-- Create the popup
local info_left = awful.popup {
    widget = {
    {
        {
            text   = "Info Panel",
            align  = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },

        margins = beautiful.useless_gap * 2,
        widget  = wibox.container.margin,
    },
    --bg     = beautiful.bg,
    shape  = beautiful.shape or gears.shape.rounded_rect,
    forced_height = 515,
    widget = wibox.container.background,
    },

    	bg = beautiful.bg_normal,
	fg = beautiful.fg_normal,
	ontop = true,
	visible = false, 
    	placement = function(c)
        	awful.placement.left(c, {
            		honor_workarea = true,
            		margins = {
                	bottom = beautiful.useless_gap * 4,
                	left   = beautiful.useless_gap * 4,
            		},
        	})
    	end,
	}

-- Toggle visibility signal
awesome.connect_signal("info_panel::toggle", function()
    info_left.visible = not info_left.visible
end)

return info_left

