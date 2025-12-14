
local M = {}

  function first_day(month, year)
    local wday = os.date("*t", os.time({ year = year, month = month, day = 1 })).wday

    if wday      ==  1
      then
          return 7
      else
          return wday - 1
      end
  end

  function month_day(month, year)
    return os.date("*t", os.time({ year=year, month=month+1, day=0 })).day
  end

  function last_month_last_day(month, year)
    return os.date("*t", os.time({ year=year, month=month, day=0 })).day
  end
--[[
  function days_before_month(month, year)
    return first_day.wday - 1
  end

  function days_after_month(month, year)
    return 42 - first_day - days_before_month
  end
]]
function generate_calendar(month, year)
  local last_month_last_day =   last_month_last_day(month, year)
  local days_before_month   =   first_day(month, year) - 1
  local month_day           =   month_day(month, year)
  local days_after_month    =   42 - month_day - days_before_month


    local calendar_days = {}

    for day =
      last_month_last_day - days_before_month, last_month_last_day - 1 do
		    table.insert(calendar_days, 
                      { day             =   day,
                        current_month   =   false
                      })
	  end
  
    for day = 1, month_day do
        table.insert(calendar_days, 
                      { day             =   day,
                        current_month   =   true
                      })
    end

    for day = 1, days_after_month do
        table.insert(calendar_days,
                       { day             =   day,
                        current_month   =   false
                      })
    end

    return calendar_days
end


function M.calendar()
    local current_month = tonumber(os.date("%m"))
    local current_year = tonumber(os.date("%Y"))

    local month_label = wibox.widget {
        text = os.date("%B %Y"),
        --font = 12,
        align = "center",
        widget = wibox.widget.textbox
    }

    local grid    =   wibox.widget {
    layout          =   wibox.layout.grid,
    column_count    =   7,
    row_count       =   6,
    spacing         =   2,
  --  border_width    =   2,
  --  border_colour   =   beautiful.bg_normal,
    }




 local function update_calendar()
    grid:reset()
    month_label.text = os.date("%B %Y", os.time{year=current_year, month=current_month, day=1})

    local days = generate_calendar(current_month, current_year)

        for _, day in ipairs(days) do
          local color = day.current_month and "#ffffff" or beautiful.border_normal 
           local day_widget = wibox.widget 
            {
              {
                {
                  markup    =   string.format("<span foreground='%s'>%d</span>", color, day.day),
                  align     = "center",
                  valign    = "center",
                  widget    = wibox.widget.textbox
                },
              widget    =   wibox.container.margin,
              margins   =   2,
              },
            widget = wibox.container.background,
            bg              =   beautiful.bg_focus,
            shape           =   gears.shape.squircle,
            }
            grid:add(day_widget)
  end
end

  local prev_button = wibox.widget { text = "\u{f137}  ", widget = wibox.widget.textbox }
  local next_button = wibox.widget { text = "\u{f138}  ", widget = wibox.widget.textbox }

    prev_button:buttons(gears.table.join(
        awful.button({}, 1, function()
            current_month = current_month - 1
            if current_month < 1 then
                current_month = 12
                current_year = current_year - 1
            end
            update_calendar()
        end)
    ))

    next_button:buttons(gears.table.join(
        awful.button({}, 1, function()
            current_month = current_month + 1
            if current_month > 12 then
                current_month = 1
                current_year = current_year + 1
            end
            update_calendar()
        end)
    ))


 local calendar_widget    =   wibox.widget 
  {
    {
      {
        prev_button,
        month_label,
        next_button,
        layout    =   wibox.layout.align.horizontal
      },
      {
        nil,
        grid,
        nil,
        layout    =   wibox.layout.align.horizontal
      },
      spacing   =   10,
      layout    =   wibox.layout.fixed.vertical,
    },
    margins   =   6,
    widget    =   wibox.container.margin,
  }

    update_calendar()
    return calendar_widget
end

return M
