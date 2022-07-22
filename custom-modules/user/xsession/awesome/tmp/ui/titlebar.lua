local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
      awful.button({ }, 1, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.move(c)
      end),
      awful.button({ }, 3, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.resize(c)
      end)
  )

  awful.titlebar(c, {
    size = dpi(24),
    position = "left",
  }):setup {
    {
        {
        awful.titlebar.widget.closebutton(c),
        layout = wibox.layout.fixed.vertical,
        },
        widget = wibox.container.margin,
        top = dpi(8),
        left = dpi(6),
        right = dpi(6),
    },
    {
        buttons = buttons,
        layout  = wibox.layout.fixed.vertical
    },
    {
        buttons = buttons,
        layout  = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.align.vertical
  }
end)