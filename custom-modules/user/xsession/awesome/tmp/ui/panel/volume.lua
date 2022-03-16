local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local speaker_svg = gears.filesystem.get_configuration_dir() .. "icons/speaker.svg"
local speaker_mute_svg = gears.filesystem.get_configuration_dir() .. "icons/speaker-mute.svg"

local slider = wibox.widget {
  value = 0,
  forced_height = dpi(10),
  widget = wibox.widget.slider,
}

local icon = wibox.widget {
  image = speaker_svg,
  forced_height = dpi(24),
  forced_width = dpi(24),
  widget = wibox.widget.imagebox,
  buttons = gears.table.join(
    awful.button({ }, 1, function ()
      slider:emit_signal("mute::toggle")
    end)
  )
}

local setvalue = function(s)
  awful.spawn.with_shell("amixer sset Master " ..s.value.. "%")
end

slider:connect_signal("property::value", setvalue)

setvalue(slider)

function pollVol(s)
  s.value = io.popen("amixer get Master | grep '%' | head -n 1 | awk -F'[' '{print $2}' | awk -F'%' '{print $1}'"):read("*all")
end

local vt = timer({ timeout = 1 })
vt:connect_signal("timeout", function () pollVol(slider) end)
vt:start()

local is_muted = false

local set_mute_state = function(b)
  if is_muted == b then
    return
  end
  is_muted = b
  
  if is_muted then
    icon.image = speaker_svg
    slider.bar_color = beautiful.slider_bar_color
    slider.handle_color = beautiful.slider_handle_color
  else
    icon.image = speaker_mute_svg
    slider.bar_color = beautiful.fg_normal
    slider.handle_color = beautiful.fg_normal
  end
end


local toggle_mute = function()
  io.popen("amixer set Master 1+ toggle > /dev/null")
  set_mute_state(not is_muted)
end

function pollMute(s)
  local mute = io.popen("amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null || echo $?"):read("*all")
  set_mute_state(string.find(mute, "1"))
end

local mt = timer({ timeout = 1 })
mt:connect_signal("timeout", function () pollMute(icon) end)
mt:start()

slider:connect_signal("mute::toggle", toggle_mute)

return wibox.widget {
  {
    {
      icon,
      slider,
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(10),
    },
    margins = dpi(20),
    widget = wibox.container.margin,
  },
  widget = wibox.container.background,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  bg = beautiful.bg_subtle,
}
