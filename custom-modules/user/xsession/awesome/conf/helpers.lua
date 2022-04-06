local gears = require("gears")

local helpers = {}

helpers.get_icon = function(name)
  return gears.filesystem.get_configuration_dir() .. "icons/" .. name .. ".svg"
end

return helpers