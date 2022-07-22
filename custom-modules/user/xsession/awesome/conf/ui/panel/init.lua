local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local variables = require("variables")
local features = variables.features

Q.panel = {}

local top_actions = wibox.widget {
  require("ui.panel.network"),
  require("ui.panel.volume"),
  layout = wibox.layout.fixed.vertical,
  spacing = dpi(16),
}

local middle_actions = wibox.widget {
  {
    require("ui.panel.vm"),
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(16),
  },
  widget = wibox.container.margin,
  top = dpi(16),
}

if (features.laptopBrightness) then
  top_actions:add(require("ui.panel.laptopBrightness"))
end

awful.spawn.easy_async_with_shell("sudo ddcutil detect | grep -c \"Display\"", function(stdout)
  local create_brightness_slider_monitor = require("ui.panel.brightness")
  for i = 1, tonumber(stdout), 1 do
    top_actions:add(create_brightness_slider_monitor(1))
  end
end)

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
