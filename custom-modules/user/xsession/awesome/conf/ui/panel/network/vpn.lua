local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local awful = require("awful")
local helpers = require("helpers")

return function (vpn_name)
  local signal_broker = gears.object{}

  local buttons = gears.table.join (
    awful.button({ }, 1, function ()
      signal_broker:emit_signal("toggle")
    end)
  )

  local label = wibox.widget{
    markup = vpn_name,
    font = beautiful.font_name .. " 11",
    align  = "right",
    valign = "center",
    forced_height = dpi(1),
    forced_width = 9999, -- force full width
    widget = wibox.widget.textbox,
    buttons = buttons,
  }

  local vpn_widget = require("ui.panel.components.block_with_icon")("lock-key-open", { label }, buttons, nil, {
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 0)
    end,
    bg = beautiful.bg_normal,
  })

  local enabled = false

  local set_state = function(s)
    enabled = s
    local color = beautiful.fg_normal
    local icon_name = "lock-key-open"
    if (enabled) then
      color = beautiful.fg_accent
      icon_name = "lock-key"
    end
    label.markup = "<span foreground='"..color.."'>"..vpn_name.."</span>"
    helpers.set_icon_color(vpn_widget.icon, color)
    vpn_widget.icon.image = helpers.get_icon(icon_name)
  end

  local pollStatus = function()
    awful.spawn.easy_async_with_shell("nmcli c show --active | awk -F' {2,}' '$3==\"vpn\" && $1==\""..vpn_name.."\" { print $1 }'", function(stdout)
      current = stdout ~= ""
      if (current == enabled) then
        return
      end

      set_state(current)
    end)
  end

  local t = timer({ timeout = 5 })
  t:connect_signal("timeout", pollStatus)
  t:start()
  pollStatus()

  local toggle = function()
    if enabled then
      awful.spawn.easy_async_with_shell("nmcli c down \""..vpn_name.."\"", function(stdout, stderr, exitreason, exitcode)
        set_state(false)
      end)
    else
      awful.spawn.easy_async_with_shell("nmcli c up \""..vpn_name.."\"", function(stdout, stderr, exitreason, exitcode)
        set_state(exitcode == 0)
      end)
    end
  end

  signal_broker:connect_signal("toggle", toggle)

  return vpn_widget.widget
end