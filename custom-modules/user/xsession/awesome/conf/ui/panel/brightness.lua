local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

local create_brightness_slider_monitor = function(display_number)
  local dn = tostring(display_number)

  local slider = wibox.widget {
    value = 0,
    forced_height = dpi(10),
    maximum = 99,
    widget = wibox.widget.slider,
  }

  local icon = wibox.widget {
    {
      image = helpers.get_icon("monitor"),
      forced_height = dpi(24),
      forced_width = dpi(24),
      widget = wibox.widget.imagebox,
    },
    {
      {
        markup = dn,
        align  = "center",
        widget = wibox.widget.textbox
      },
      top = dpi(1),
      bottom = dpi(2),
      left = dpi(1),
      right = dpi(2),
      widget = wibox.container.margin,
    },
    layout = wibox.layout.stack,
  }

  local debounce = 0
  local prev_value = 0

  local setvalue = function(s)
    debounce = debounce + 1
    gears.timer.start_new(0.5, function()
      debounce = debounce - 1
      if (debounce > 0) then
        return
      end
      if (prev_value == s.value) then
        return false
      end
      awful.spawn.with_shell("sudo ddcutil -d "..dn.." setvcp 10 " ..s.value)
      return false
    end)
  end

  slider:connect_signal("property::value", setvalue)

  function pollBrightness(s)
    if (debounce > 0) then
      return
    end
    awful.spawn.easy_async_with_shell("sudo ddcutil -d "..dn.." getvcp 10 | sed -n \"s/.*current value = *\\([^']*\\), max value =   100.*/\\1/p\"", function (stdout)
      prev_value = tonumber(stdout)
      if (prev_value == nil) then
        prev_value = 0
      end
      s.value = prev_value
    end)
  end

  pollBrightness(slider)

  local bt = timer({ timeout = 60 })
  bt:connect_signal("timeout", function () pollBrightness(slider) end)
  bt:start()

  return require("ui.panel.components.block")({
    icon,
    slider,
  })
end

return create_brightness_slider_monitor