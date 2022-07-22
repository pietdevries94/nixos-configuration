local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local tmpl = require("ui.panel.vm.template")

local macOSStop = "ssh piet@macOS \"sudo shutdown -h now\""

local vpn_list = wibox.widget {
  layout = wibox.layout.fixed.vertical,
  spacing = dpi(16),
  tmpl("windows-logo", "win10"),
  tmpl("apple-logo", "macOS", macOSStop),
}

return vpn_list