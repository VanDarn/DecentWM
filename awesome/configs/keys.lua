local signals = require("configs.signals")

local keys = {}

local modkey = "Mod4"
local terminal = "alacritty"
local browser = "firefox"
local tag_count = 6
keys.tags = tag_count

-- Vanilla keys(more or less) -> Redo, search for better solutions, include global variables

keys.globalkeys = gears.table.join(
 
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, }, "d", function()
	    awesome.emit_signal("info_left::toggle")
    		end,
              {description = "toggle info panels", group = "awesome"}),






    awful.key({ modkey, }, "p", function()
        -- Define a one-time signal listener function
        local function battery(status, charge)
--        local function on_vol_value(mute, volume)
            -- Show notification with JUST the output (mute and volume)
            naughty.notify({
                title = status .. " " .. charge .. " ",
                timeout = 3,
            })
            -- Disconnect listener immediately to avoid repeated notifications
            awesome.disconnect_signal("bat::value", battery)
--            awesome.disconnect_signal("vol::value", on_vol_value)
    end

        -- Connect the signal listener
    awesome.connect_signal("bat::value", battery)
--    awesome.connect_signal("vol::value", on_vol_value)

        -- Trigger volume update
        signals.bat()
--        signals.vol()
    end, {description = "Show volume status", group = "custom"}),






    -- Programms
    awful.key({ modkey, }, "b", function () awful.spawn(browser) end,
              {description = "opens browser", group = "awesome"}),
 
    -- Window Managment
    awful.key({ modkey,           }, "Left", function () awful.client.focus.bydirection("left") end,
              {description = "Focus left client", group = "client"}),
    awful.key({ modkey,           }, "Right", function () awful.client.focus.bydirection("right") end,
              {description = "Focus right client", group = "client"}),	
    awful.key({ modkey,           }, "Up", function () awful.client.focus.bydirection("up") end,
              {description = "Focus up", group = "client"}),
    awful.key({ modkey,           }, "Down", function () awful.client.focus.bydirection("down") end,
              {description = "Focus down", group = "client"}),


    awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn.with_shell("brightnessctl set 5%+ -q") end),
    awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn.with_shell("brightnessctl set 5%- -q") end),

    awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn.with_shell("pamixer -i 5")
		signals.vol()
	end),
    awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn.with_shell("pamixer -d 5")
		signals.vol()
	end),
    awful.key({}, "XF86AudioMute", function()
		awful.spawn.with_shell("pamixer --toggle-mute")
		signals.vol()
	end)

)

keys.clientkeys = gears.table.join(

    awful.key({ modkey,    }, "q", function(c)	c:kill() end)	      
)	
	      


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, tag_count do
    keys.globalkeys = gears.table.join(
        keys.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function()
                        local tag = awful.screen.focused().tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),

        awful.key({ modkey, "Shift"}, "#" .. i + 9,
                  function()
                        local tag = awful.screen.focused().tags[i]
                        if tag then
                           client.focus:move_to_tag(tag)
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}
		  )
		  )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(keys.globalkeys)



return keys
