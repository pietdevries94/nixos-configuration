local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

local wifi_ssid = wibox.widget{
  markup = "",
  font = beautiful.font_name .. " 11",
  align  = "right",
  valign = "center",
  forced_height = dpi(1),
  forced_width = 9999, -- force full width
  widget = wibox.widget.textbox,
}

local wifi_widget = require("ui.panel.components.block_with_icon")("wifi-high", { wifi_ssid }, gears.table.join (
  awful.button({ }, 1, function ()
    awful.spawn(terminal .. " --class nmtui -e nmtui")
  end)
), nil, {
  shape = function(cr, width, height)
    gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, 5)
  end,
})

local ssid = ""
local wifi_connected = false
local strength = 0

local get_ssid = function()
  awful.spawn.easy_async_with_shell("nmcli c show --active | awk '$3==\"wifi\" { print $1 }'", function (stdout)
    ssid = stdout
    wifi_ssid.markup = "<span foreground='"..beautiful.fg_normal.."'>"..tostring(ssid).."</span>"

    connected = ssid ~= ""
    if (wifi_connected == connected) then
      return
    end

    wifi_connected = connected

    if (connected) then
      wifi_widget.icon.image = helpers.get_icon("wifi-high")
    else
      strength = 0
      wifi_widget.icon.image = helpers.get_icon("wifi-slash")
    end
  end)
end

local wifi_ssid_timer = timer({ timeout = 1 })
wifi_ssid_timer:connect_signal("timeout", get_ssid)
wifi_ssid_timer:start()

local get_strength = function()
  awful.spawn.easy_async_with_shell("nmcli dev wifi list | awk '/\\*/{if (NR!=1) {print $8}}'", function (stdout)
    if (stdout == "") then
      strength = 0
      wifi_widget.icon.image = helpers.get_icon("wifi-slash")
      return
    end
    strength = tonumber(stdout)
    
    local icon = "wifi-none"
    if (strength > 75) then
      icon = "wifi-high"
    elseif (strength > 50) then
      icon = "wifi-medium"
    elseif (strength > 10) then
      icon = "wifi-low"
    end

    wifi_widget.icon.image = helpers.get_icon(icon)
  end)
end

local wifi_strength_timer = timer({ timeout = 15 })
wifi_strength_timer:connect_signal("timeout", get_strength)
wifi_strength_timer:start()
get_strength()

return wifi_widget.widget