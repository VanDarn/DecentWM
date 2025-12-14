
local get_taglist = function(s)
	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			spacing = 2,
			layout = wibox.layout.fixed.horizontal,
		},
		style = {
			shape = gears.shape.rounded_rect,
		},
		buttons = gears.table.join(
			awful.button({}, 1, function(t)
				t:view_only()
			end),
			awful.button({ modkey }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
			awful.button({}, 3, awful.tag.viewtoggle),
			awful.button({ modkey }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
			awful.button({}, 4, function(t)
				awful.tag.viewprev(t.screen)
			end),
			awful.button({}, 5, function(t)
				awful.tag.viewnext(t.screen)
			end)
	)
})

end

return get_taglist
