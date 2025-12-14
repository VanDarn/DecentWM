local variables   =   require("variables")
local syst        =   require("ui.info_left.syst")
--local calendar    =   require("ui.info_left.calendar")

local weather    =   require("ui.info_left.widgets.weather")

local user = wibox.widget (
  {
     {
      {
      syst.user,
      layout    =   wibox.layout.fixed.horizontal,
      spacing   =   5,
      },
      widget = wibox.container.margin,
      margins = 5,
    },
      widget = wibox.container.background,
      forced_width = variables.screen_width * 0.25,
      forced_height = variables.screen_height * 0.15,
      bg = beautiful.bg_focus,
      shape = 
		gears.shape.rounded_rect,
   }
  )



local cal = wibox.widget (
   {
    {
      {
      syst.cal,
        {
          syst.appoint1,
          syst.appoint2,
          syst.appoint3,
          layout    =   wibox.layout.fixed.vertical,
          spacing   =   5,
        },
      layout    =   wibox.layout.fixed.horizontal,
      spacing   =   5,
      },
      widget = wibox.container.margin,
      margins = 5,
    },
    widget = wibox.container.background,
    --forced_width = variables.screen_width * 0.25,
    forced_height = variables.screen_height * 0.25,
    bg = beautiful.bg_focus,
    shape = gears.shape.rounded_rect,
  
 })


local weather = wibox.widget (
  {
    {
      {
      weather.main,
      layout    =   wibox.layout.fixed.vertical,
      spacing   =   5,
      },
      widget = wibox.container.margin,
      margins = 5,
    },
      widget = wibox.container.background,
      forced_width = variables.screen_width * 0.25,
      forced_height = variables.screen_height * 0.3,
      bg = beautiful.bg_focus,
      shape = 
		gears.shape.rounded_rect,
   }
  )




-- Create the popup
local info_left = awful.popup {
	screen = s,
	widget = wibox.container.background,
	ontop = true,
	bg = beautiful.bg,
	visible = false,
	opacity = 1,
  placement = function(w)
--        awful.placement.center_vertical(c, { honor_workarea = true })
        awful.placement.top_left(w, {
            honor_workarea = true,
            margins = { bottom = variables.screen_height * 0.05,
                        top = variables.screen_height * 0.01,
                        left = beautiful.useless_gap * 2, right = beautiful.useless_gap}
        })
  end,
 
  shape = gears.shape.rounded_rect,
}


info_left:setup {
  {
    user,
    cal,
    weather,
    layout = wibox.layout.fixed.vertical,
      spacing = 5,
  },
        widget = wibox.container.margin,
        margins = 5,
        forced_width = variables.screen_width * 0.3,
}


awesome.connect_signal("info_left::toggle", function()
	info_left.visible = not info_left.visible 
end
)

