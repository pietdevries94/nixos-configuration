local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

return function(icon, items, icon_buttons, icon_options, block_options)
  local icon = require("ui.panel.components.icon")(icon, icon_buttons)

  local all_items = {icon}
  for key, value in pairs(items) do
    table.insert(all_items, value)
  end
  
  local widget = require("ui.panel.components.block")(all_items, block_options)
  
  return {
    icon = icon,
    widget = widget
  }
end
