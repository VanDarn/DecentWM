local user        =   require("user")
local variables   =   require("variables")


local APP_key           =   user.APP_key
local city_id           =   user.city_id
local command           =   
        [[
          bash -c '
          KEY="]]..APP_key..[["
          CITY="]]..city_id..[["
          weather=$(curl -sf 
            "http://api.openweathermap.org/data/2.5/forecast?APPID=$KEY&id=$CITY&units=metric")

          weather_temp=$(echo "$weather" \
            | jq -r '.list[]
            | select(.dt_txt | test("12:00:00"))
            | [.dt_txt, .main.temp, .weather[0].icon, .pop]
            | @tsv')
        ]]


local M = {}
awful.widget.watch(command, 600, function(_, stdout, stderr)
  local result = stdout

  for l in result:gmatch("[^\r\n]+") do
    local date, temp, icon, chance = l:match("([^\t]+)\t([^\t]+)\t([^\t]+)\t([^\t]+)")
    table.insert (wdata , {
      date      =   date,
      temp      =   temp,
      icon      =   icon,
      chance    =   chance
    })


    M.forecast_1.update(wdata[1])
    M.forecast_2.update(wdata[2])
    M.forecast_3.update(wdata[3])
    M.forecast_4.update(wdata[4])
    M.forecast_5.update(wdata[5])
    M.forecast_6.update(wdata[6])


  end
end)

M.forecast_widget   =   function()
  local widget    =   wibox.widget({
    {
      id        =   "icon",
      widget    =   wibox.widget.textbox,
      text      =   ""
    },
    {
      {
        id        =   "temp",
        widget    =   wibox.widget.textbox,
        text      =   "Error!"
      },
      { 
        id        =   "chance",
        widget    =   wibox.widget.textbox,
        text      =   "-/-"
      },
      layout    =   wibox.layout.fixed.vertical
    },
    layout    =   wibox.layout.fixed.horizontal
  })
   for i = 1, 6 do
        local entry = M.data[i]
        local widget = M["forecast_" .. i]
        if entry and widget then
            widget.update(entry)
        end
    end
  widget.update = function(wdata)
    for _, ret in ipairs(wdata) do
      widget:get_children_by_id("temp")[1].text     =   ret.temp
      widget:get_children_by_id("icon")[1].text     =   ret.icon
      widget:get_children_by_id("chance")[1].text   =   ret.chance
    end
  end
  return widget
end

M.forecast_1    =   M.forecast_widget()
M.forecast_2    =   M.forecast_widget()
M.forecast_3    =   M.forecast_widget()
M.forecast_4    =   M.forecast_widget()
M.forecast_5    =   M.forecast_widget()
M.forecast_6    =   M.forecast_widget()


M.weather   =   wibox.widget({
  {
    M.forecast_1,
    M.forecast_2,
    M.forecast_3,
    M.forecast_4,
    M.forecast_5,
    M.forecast_6,
    layout    =   wibox.layout.fixed.horizontal
  },
})


return M
