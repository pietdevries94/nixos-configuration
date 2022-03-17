local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

Q.panel = {}

local top_actions = wibox.widget {
  require("ui.panel.volume"),
  layout = wibox.layout.fixed.vertical,
  spacing = dpi(16),
}

gears.timer.delayed_call(function ()
  local number_of_displays = tonumber(io.popen("sudo ddcutil detect | grep -c \"Display\""):read("*all"))
  local create_brightness_slider_monitor = require("ui.panel.brightness")
  top_actions:add(create_brightness_slider_monitor(1))
  top_actions:add(create_brightness_slider_monitor(2))
end)

local middle_actions = wibox.widget {
  layout = wibox.layout.fixed.vertical,
  spacing = dpi(16),
}

local bottom_actions = wibox.widget {
  require("ui.panel.buttons"),
  layout = wibox.layout.fixed.vertical,
  spacing = dpi(16),
}

local panel = awful.popup {
  widget = {
    widget = wibox.container.margin,
    margins = dpi(16),
    forced_width = dpi(352),
    {
      top_actions,
      middle_actions,
      bottom_actions,
      layout = wibox.layout.align.vertical,
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
