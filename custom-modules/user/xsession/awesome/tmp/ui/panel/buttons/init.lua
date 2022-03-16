local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local get_icon = function(name)
  return gears.filesystem.get_configuration_dir() .. "icons/" .. name .. ".svg"
end

local create_icon_button = function(name, fn)
  return wibox.widget {
    {
      {
        image = get_icon(name),
        forced_height = dpi(24),
        forced_width = dpi(24),
        widget = wibox.widget.imagebox,
      },
      margins = dpi(16),
      widget = wibox.container.margin,
    },
    widget = wibox.container.background,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 5)
    end,
    bg = beautiful.bg_subtle,
    buttons = gears.table.join(
      awful.button({ }, 1, fn)
    )
  }
end

local shutdown = create_icon_button(
  "power",
  function()
    io.popen("shutdown now")
  end
)

local reboot = create_icon_button(
  "arrow-clockwise",
  function()
    io.popen("reboot")
  end
)

local sign_out = create_icon_button(
  "sign-out",
  function()
    awesome.quit()
  end
)

return wibox.widget {
  shutdown,
  reboot,
  sign_out,
  layout = wibox.layout.fixed.horizontal,
  spacing = dpi(10),
}
