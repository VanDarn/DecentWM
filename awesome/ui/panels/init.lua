




       local panel_l = awful.popup({
		widget = {

		},

                        bg = beautiful.bg,
                        fg = beautiful.fg,
			placement = function(c)
				return awful.placement.bottom_left(c, {
					honor_workarea = true,
					margins = {
						bottom = beautiful.useless_gap * 4,
						left = beautiful.useless_gap * 4,
						},
					})
			end,
			visible = false,
                })
	

--[[
        local panel_r = awful.popup({
                        bg = beautiful.bg,
                        fg = beautiful.fg,
			visible = false,
                })
                :setup({
                expand = "none",
                layout = wibox.layout.align.horizontal,
                })


]]

	awesome.connect_signal("info_panel::toggle", function(scr)
		if scr == s then panel_l.visible = not panel_l.visible end
	end)

	

