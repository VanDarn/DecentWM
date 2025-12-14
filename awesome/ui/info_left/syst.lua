
local variables   =   require("variables")
local calendar    =   require("ui.info_left.calendar")




local M = {}



M.user = wibox.widget ({
  {
    {
      {
      widget = wibox.container.background,
      forced_height   =   variables.screen_width * 0.05,
      forced_width    =   variables.screen_width * 0.05,
      bg              =   beautiful.bg_normal,
      --border_width    =   5,
      --border_colour   =   beautiful.bg_normal,
      shape           =   gears.shape.rounded_rect,
    },
      {
      widget = wibox.container.background,
      forced_height   =   variables.screen_height * 0.05,
      forced_width    =   variables.screen_width * 0.15,
      bg              =   beautiful.bg_normal,
      --border_width    =   5,
      --border_colour   =   beautiful.bg_normal,
      shape           =   gears.shape.rounded_rect,
      },
      layout    =   wibox.layout.fixed.horizontal,
      spacing   =   5,
    },
    widget    =   wibox.container.margin,
    color     =   beautiful.bg, 
    margins   =   5,
  },
  layout    =   wibox.layout.fixed.vertical,
  spacing   =   5,
 
})




 M.cal = wibox.widget 

{
  {
    calendar.calendar(),
    margins   =   6,
    widget    =   wibox.container.margin
  },
    bg              =   beautiful.bg_normal,
    shape           =   gears.shape.rounded_rect,
    forced_width    =   variables.screen_width * 0.15,
    widget          =   wibox.container.background
}




M.appoint1   =   wibox.widget
{
  {
    {
      widget    =   wibox.widget.textbox,
    },
        margins   =   6,
        widget    =   wibox.container.margin
  },
    bg              =   beautiful.bg_normal,
    shape           =   gears.shape.rounded_rect,
    forced_width    =   variables.screen_width * 0.1,
    forced_height   =   variables.screen_height * 0.05,
    widget          =   wibox.container.background
}


M.appoint2   =   wibox.widget
{
  {
    {
      widget    =   wibox.widget.textbox,
    },
        margins   =   6,
        widget    =   wibox.container.margin
  },
    bg              =   beautiful.bg_normal,
    shape           =   gears.shape.rounded_rect,
    forced_width    =   variables.screen_width * 0.1,
    forced_height   =   variables.screen_height * 0.05,
    widget          =   wibox.container.background
}


M.appoint3   =   wibox.widget
{
  {
    {
      widget    =   wibox.widget.textbox,
    },
        margins   =   6,
        widget    =   wibox.container.margin
  },
    bg              =   beautiful.bg_normal,
    shape           =   gears.shape.rounded_rect,
    forced_width    =   variables.screen_width * 0.1,
    forced_height   =   variables.screen_height * 0.05,
    widget          =   wibox.container.background
}


return M

