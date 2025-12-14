

tags = { "1", "2", "3", "4", "5", "6" }

local screen = awful.screen.focused()
local screen_width = screen.geometry.width
local screen_height = screen.geometry.height

default_layout = awful.layout.suit.tile

return {
  tags = tags,
  screen_width = screen_width,
  screen_height = screen_height,
  default_layout = default_layout,
}
