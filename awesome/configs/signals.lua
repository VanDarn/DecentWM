local M = {}

local bat =
	[[ charge=$(acpi | awk -F' ' '{print $4}' | xargs | tr -d '[%,]'); printf "$(acpi | awk -F' ' '{print $3}' | xargs | tr -d '[,]') ${charge% *}\n" ]]

local vol = [[ str=$( pamixer --get-volume 2>/dev/null | xargs ); printf "$(pamixer --get-mute 2>/dev/null | xargs) ${str% *}\n" ]]





M.vol = function()
	awful.spawn.easy_async_with_shell(vol, function(out)
		local val = gears.string.split(out, " ")
		awesome.emit_signal("vol::value", val[1]:match("true") and 1 or 0, tonumber(val[2]))
	end)
end


M.bat = function()
	awful.spawn.easy_async_with_shell(bat, function(out)
		local val = gears.string.split(out, " ")
		awesome.emit_signal("bat::value", val[1], tonumber(val[2]))
	end)
end






gears.timer({
	timeout = 180,
	call_now = true,
	autostart = true,
	callback = function()
		M.bat()
	end,
})



return M
