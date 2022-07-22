local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

local speaker_svg = helpers.get_icon("speaker")
local speaker_mute_svg = helpers.get_icon("speaker-mute")

local volume_signal_broker = gears.object{}

local vol = require("ui.panel.components.slider_block")("speaker", nil, gears.table.join (
  awful.button({ }, 1, function ()
    volume_signal_broker:emit_signal("mute::toggle")
  end),
  awful.button({ }, 3, function ()
    awful.spawn("pavucontrol")
  end)
))

local setvalue = function(s)
  awful.spawn.with_shell("amixer sset Master " ..s.value.. "%")
end

vol.slider:connect_signal("property::value", setvalue)

setvalue(vol.slider)

function pollVol(s)
  awful.spawn.easy_async_with_shell("amixer get Master | grep '%' | head -n 1 | awk -F'[' '{print $2}' | awk -F'%' '{print $1}'", function (stdout)
    s.value = tonumber(stdout)
  end)
end

local vt = timer({ timeout = 1 })
vt:connect_signal("timeout", function () pollVol(vol.slider) end)
vt:start()

local is_muted = false

local set_mute_state = function(b)
  if is_muted == b then
    return
  end
  is_muted = b
  
  if is_muted then
    vol.icon.image = speaker_svg
    vol.slider.bar_color = beautiful.slider_bar_color
    vol.slider.handle_color = beautiful.slider_handle_color
  else
    vol.icon.image = speaker_mute_svg
    vol.slider.bar_color = beautiful.fg_normal
    vol.slider.handle_color = beautiful.fg_normal
  end
end


local toggle_mute = function()
  awful.spawn.with_shell("amixer set Master 1+ toggle > /dev/null")
  set_mute_state(not is_muted)
end

function pollMute(s)
  awful.spawn.easy_async_with_shell("amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null || echo $?", function (stdout)
    set_mute_state(string.find(stdout, "1"))
  end)
end

local mt = timer({ timeout = 1 })
mt:connect_signal("timeout", function () pollMute(icon) end)
mt:start()

volume_signal_broker:connect_signal("mute::toggle", toggle_mute)

return vol.widget