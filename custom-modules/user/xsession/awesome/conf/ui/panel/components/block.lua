local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

return function(items, options, layout)
  if layout == nil then
    layout = wibox.layout.fixed.horizontal
  end
  local vert = {
    layout = layout,
    spacing = dpi(10),
  }

  for key, value in pairs(items) do
    table.insert(vert, value)
  end

  local block = wibox.widget {
    {
      vert,
      margins = dpi(20),
      widget = wibox.container.margin,
    },
    widget = wibox.container.background,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 5)
    end,
    bg = beautiful.bg_subtle,
  }

  if (options ~= nil) then
    for key, value in pairs(options) do
      block[key] = value
    end
  end

  return block
end