local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

Q.panel = {}

local actions = wibox.widget {
  {
    require("ui.panel.volume"),
    require("ui.panel.buttons"),
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(16),
  },
  widget = wibox.container.margin,
}

local panel = awful.popup {
  widget = {
    widget = wibox.container.margin,
    margins = dpi(16),
    forced_width = dpi(352),
    {
      layout = wibox.layout.fixed.vertical,
      actions,
    },
  },
  placement = function(c)
    (awful.placement.right + awful.placement.maximize_vertically)(c)
  end,
  ontop = true,
  visible = false,
  bg = beautiful.bg_normal,
}

Q.panel.toggle = function()
  if panel.visible == false then
    panel.visible = true
    panel.screen = awful.screen.focused()
  elseif panel.screen.index ~= awful.screen.focused().index then
    panel.screen = awful.screen.focused()
  else
    panel.visible = false
  end
end
