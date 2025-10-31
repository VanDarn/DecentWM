pcall(require, "luarocks.loader")


--Core libraries

gears = require("gears")
awful = require("awful")
require("awful.autofocus")


--Theme library

beautiful = require("beautiful")

naughty = require("naughty")
wibox = require("wibox")
require("awful.hotkeys_popup.keys")


local error_handling = require("error_handling")
error_handling.init()


-- Layout

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
}

require("configs")

require("ui")
