local screen = require("configs.screen")
local signals = require("configs.signals")

local M = {}

---------------------
------Seperator------
---------------------

M.sep = wibox.widget({
	
		orientation = "vertical",
		shape = gears.shape.line,
		widget = wibox.widget.separator,
	
})


-------------------
------Systray------
-------------------

M.systray = wibox.widget.systray()


-----------------
------Clock------
-----------------

M.clock = wibox.widget({
--	font = beautiful.barfont,
	format = "%H:%M ",
	refresh = 1,
	align = "center",
	valign = "center",
	widget = wibox.widget.textclock,
})


-------------------
------Battery------
-------------------

M.battery = wibox.widget({
	widget = wibox.widget.textbox,
--	font = "FontAwesome 12",
--	valign = "center",
--	halign = "center",
})


awesome.connect_signal("bat::value", function(status, charge)
	local icon = "\u{f244}"


	if charge > 80 --and charge < 95 
		then
		icon = "\u{f240}"
	elseif charge >= 55 and charge < 80 
		then
		icon = "\u{f241}"
	elseif charge >= 20 and charge < 55 
		then
		icon = "\u{f242}"
	elseif charge >= 10 and charge < 20 
		then
		icon = "\u{f243}"
	else
		icon = "\u{f244}"
	end


	--[[
	if status == "Charging" or status == "Full" then
		icon = help.fg(icon, beautiful.ok, "normal")
		if charge >= 90 then
			naughty.notify({
				title = "Battery charged",
				text = charge .. "% full",
				timeout = 4,
			})
		end

	elseif charge < 20 and status == "Discharging" then
		icon = help.fg(icon, beautiful.err, "normal")
		naughty.notify({
			title = "Low battery",
			text = charge .. "% battery remaining",
			preset = naughty.config.presets.critical,
			timeout = 4,
		})
	end
--]]
M.battery.markup = icon .. "  " .. charge .. "%" 
 
end)


------Volume------
------------------

M.vol = wibox.widget({
	widget = wibox.widget.textbox,
--	font = "FontAwesome 12",
--	valign = "center",
--	halign = "center",
})


awesome.connect_signal("vol::value", function(mute, volume)


M.vol.markup = "\u{f025}  "


if mute == 1 then
		M.vol.opacity = 0.5
		M.vol.markup = "\u{f026}  "
	else
		M.vol.opacity = 0.5 + volume / 200  
		M.vol.markup = "\u{f028}  "
	end
end)

return M
