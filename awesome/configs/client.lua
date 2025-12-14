local keys = require("configs.keys")
local variables = require("variables")



awful.rules.rules = {
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_color,
			focus = awful.client.focus.filter,
			raise = true,
			maximized = false,
			keys = keys.clientkeys,
			buttons = keys.clientbuttons,
			screen = awful.screen.preferred,
		},
	}
}



-- Sloppy Focus
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

client.connect_signal("property::maximized", function(c)
	c.maximized = false
end)

client.connect_signal("property::minimized", function(c)
	c.minimized = false
end)
