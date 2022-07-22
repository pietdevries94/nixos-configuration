local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

return function(icon, buttons, options)
  local icon = wibox.widget {
    image = helpers.get_icon(icon),
    forced_height = dpi(24),
    forced_width = dpi(24),
    widget = wibox.widget.imagebox,
    buttons = buttons,
  }

  helpers.set_icon_color(icon, beautiful.fg_normal)

  if (options ~= nil) then
    for key, value in pairs(options) do
      icon[key] = value
    end
  end
  
  return icon
end
