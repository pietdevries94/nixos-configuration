local gears = require("gears")
local beautiful = require("beautiful")

local helpers = {}

helpers.set_icon_color = function(icon, color)
  icon.stylesheet = "" ..
  "*[stroke=\"#000\"] { stroke: " .. color .. "; } "..
  "*[stroke=\"#000000\"] { stroke: " .. color .. "; } "..
  "*[fill=\"#000\"] { fill: " .. color .. "; } "..
  "*[fill=\"#000000\"] { fill: " .. color .. "; } "
end

helpers.get_icon = function(name)
  return gears.filesystem.get_configuration_dir() .. "icons/" .. name .. ".svg"
end

return helpers