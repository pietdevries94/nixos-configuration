local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

return function(icon, name, stopCmd)
  if stopCmd == nil then
    stopCmd = "sudo virsh shutdown "..name
  end

  local running = false

  local logo = require("ui.panel.components.icon")(icon)
  local status = wibox.widget{
    markup = "",
    font = beautiful.font_name .. " 11",
    align  = "left",
    valign = "center",
    forced_height = dpi(1),
    widget = wibox.widget.textbox,
  }

  local power_button = require("ui.panel.components.icon")("power", gears.table.join(
    awful.button({ }, 1, function ()
      if running then
        awful.spawn.with_shell(stopCmd)
      else
        awful.spawn.with_shell("sudo virsh start "..name)
      end
    end)
  ))
  
  local res = require("ui.panel.components.block")(
    {
      logo,
      {
        status,
        left = dpi(10),
        widget = wibox.container.margin,
      },
      {
        power_button,
        spacing = dpi(10),
        layout = wibox.layout.fixed.horizontal
      }
    },
    nil,
    wibox.layout.align.horizontal
  )

  local running = false

  function trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
  end

  function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
  end

  function pollState()
    awful.spawn.easy_async_with_shell("sudo virsh domstate --domain "..name, function (stdout)
      state = firstToUpper(trim(stdout))
      running = state == "Running"

      local color = beautiful.fg_minimize
      if running then
        color = beautiful.fg_accent
      end
      status.markup = "<span foreground='"..color.."'>"..state.."</span>"
      helpers.set_icon_color(logo, color)
    end)
  end
  
  local st = timer({ timeout = 1 })
  st:connect_signal("timeout", pollState)
  st:start()
  pollState()
  
  return res
end
