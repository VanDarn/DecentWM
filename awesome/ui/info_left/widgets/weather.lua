local user        =   require("user")
local variables   =   require("variables")


local APP_key           =   user.APP_key
local city_id           =   user.city_id
local command = "bash -c '"
	.. 'KEY="'
	.. APP_key
	.. '";'
	.. 'CITY="'
	.. city_id
	.. '";'
	.. 'weather=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?APPID=$KEY&id=$CITY&units=metric");'
	.. 'weather_out=$(echo "$weather" | jq -r ".list[] | select(.dt_txt) | \\"\\(.dt_txt) \\(.main.temp) \\(.weather[0].icon) \\(.pop)\\"");'
	.. 'echo "$weather_out";'
	.. "'"

M = {}

M.fcast = {}

M.main    =   wibox.widget {
    layout          =   wibox.layout.grid,
    column_count    =   3,
    row_count       =   3,
    spacing         =   2,
}

--[[
awful.spawn.easy_async_with_shell(command, function(out)
    naughty.notify({
        title = "Weather Forecast",
        text  = out,
        timeout = 10,
    })
end)
--]]


awful.widget.watch(command, 600, function(_, stdout)
  M.fcast = {}

  for line in stdout:gmatch("[^\r\n]+") do

    local dt_day, dt_time, temp_C, iconsymb, r_pop =
              line:match("([^%s]+)%s([^%s]+)%s([^%s]+)%s([^%s]+)%s([^%s]+)")
    table.insert (M.fcast, {
                        dt_day      =   dt_day,
                        dt_time     =   dt_time,
                        temp_C      =   temp_C,
                        iconsymb    =   iconsymb,
                        r_pop       =   r_pop,
                      })

    end




M.main:reset()


local function rounding(n)
    if n >= 0 then
        return math.ceil(n)
    else
        return math.floor(n)
    end
end


for _,value in ipairs(M.fcast)
  do
    local rounding_temp_C   =   rounding(value.temp_C)
      local w_widget    =   wibox.widget(
      {
        {
          text   = tostring(rounding_temp_C),
          widget = wibox.widget.textbox,
        },
        bg              =   beautiful.bg_normal,
        shape           =   gears.shape.rounded_rect,
        forced_width    =   variables.screen_width * 0.06,
        forced_height   =   variables.screen_width * 0.05,
        widget          =   wibox.container.background
      })

    M.main:add(w_widget)
    
  end
end)


return M


--[[
awful.widget.watch(command, 600, function(_, stdout)
  fcast = {}

  for line in stdout:gmatch("[^\r\n]+") do

    local dt_day, dt_time, temp_C, iconsymb, r_pop = 
              line:match("([^%s]+)%s([^%s]+)%s([^%s]+)%s([^%s]+)%s([^%s]+)")
    table.insert (fcast , {
                        dt_day      =   dt_day,
                        dt_time     =   dt_time,
                        temp_C      =   temp_C,
                        iconsymb    =   iconsymb,
                        r_pop       =   r_pop
                      })

    end


M.main:reset()


    for _, values in ipairs(fcast)
      do
    M.main:add(wttrwidget(values.temp_C))
  
  end
end)


return M
--]]


