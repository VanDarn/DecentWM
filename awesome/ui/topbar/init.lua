local syst = require("ui.topbar.syst")
--local tags = require("ui.topbar.tags")
local variables = require("variables")

local main = wibox.widget({
	{
		syst.clock,
--		syst.battery,
		layout = wibox.layout.fixed.horizontal,
	},
	widget = wibox.container.margin,
	margins = { left = 10, right = 10 },
	})


local tags = function(s)
	return wibox.widget({
		require("ui.topbar.tags")(s),
		widget = wibox.container.margin,
		margins = 4,
	})
end


local syst = wibox.widget({
	{
		syst.systray,
		syst.vol,
		syst.battery,
		layout = wibox.layout.fixed.horizontal,
	},
	widget = wibox.container.margin,
	 margins = { left = 10, right = 10 },
	})


awful.screen.connect_for_each_screen(function(s)
	awful
		.wibar({
			position = "top",
			bg = beautiful.bg,
			fg = beautiful.fg,
			width = beautiful.bar_width,
			height =  beautiful.useless_gap * 5,
			margins = { top = beautiful.useless_gap, left = beautiful.useless_gap,
        right = beautiful.useless_gap},
			screen = s,
		})
                :setup({
		main,
		tags(s),
		syst,
		expand = "none",
		layout = wibox.layout.align.horizontal,
		})

end)


