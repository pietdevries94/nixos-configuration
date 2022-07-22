local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

local bw = require("ui.panel.components.slider_block")("laptop")

local setLaptopBrightnessValue = function(s)
  awful.spawn.with_shell("light -S " ..s.value)
end

bw.slider:connect_signal("property::value", setLaptopBrightnessValue)

function pollLaptopBrightness(s)
  awful.spawn.easy_async_with_shell("light -G", function(stdout)
    s.value = tonumber(stdout)
  end)
end

local lbt = timer({ timeout = 1 })
lbt:connect_signal("timeout", function () pollLaptopBrightness(bw.slider) end)
lbt:start()

return bw.widget
