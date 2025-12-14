local syst = require("ui.info_left.syst")

-- Create the popup
local info_left = awful.popup {
	screen = s,
	widget = wibox.container.background,
	ontop = true,
	bg = beautiful.bg,
	visible =
    true,
    --false,
	forced_width = 450,
	maximum_height = 950,
	placement = function(c)
		awful.placement.left(c,
			{ margins = { top = dpi(43), bottom = dpi(8), left = dpi(8), right = dpi(8) } })
	end,
	shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 0)
	end,
	opacity = 1
}

info_left:setup {
{
  {
		{
			syst.weather,
			layout = wibox.layout.align.vertical
		},
    syst.cal,
		layout = wibox.layout.fixed.vertical
	},
  layout = wibox.layout.fixed.vertical
  },
	widget = wibox.container.margin,
	bg = beautiful.bg,
  margins = 10,
	shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 10)
	end,
}	
