local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")

local widgets_layout = wibox.widget {
  layout = wibox.layout.fixed.vertical,
  require("ui.panel.network.wifi"),
}

local network_panel = wibox.widget {
  widgets_layout,

  widget = wibox.container.background,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  shape_border_width = dpi(1),
  shape_border_color = beautiful.bg_focus,
}

awful.spawn.easy_async_with_shell("nmcli c show | awk -F' {2,}' '$3==\"vpn\" { print $1 }'", function(stdout)
  for line in stdout:gmatch("([^\n]*)\n?") do
    if (line ~= "") then
      widgets_layout:add(require("ui.panel.network.vpn")(line))
    end
  end
end)

return network_panel