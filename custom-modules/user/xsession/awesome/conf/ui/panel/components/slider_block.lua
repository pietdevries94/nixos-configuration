local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

return function(icon, slider_options, icon_buttons)
  local slider = wibox.widget {
    value = 60,
    forced_height = dpi(10),
    widget = wibox.widget.slider,
  }

  if (slider_options ~= nil) then
    for key, value in pairs(slider_options) do
      slider[key] = value
    end
  end
  
  
  local res = require("ui.panel.components.block_with_icon")(
    icon,
    { slider },
    icon_buttons
  )
  
  return {
    slider = slider,
    icon = res.icon,
    widget = res.widget
  }
end