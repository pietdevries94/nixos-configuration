local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

Q.panel = {}

local panel = awful.popup {
  widget = {
    {
        {
          {
            text   = 'foobar',
            widget = wibox.widget.textbox
          },
          {
            bar_shape           = gears.shape.rounded_rect,
            bar_height          = 3,
            bar_color           = beautiful.border_color,
            handle_color        = beautiful.bg_normal,
            handle_shape        = gears.shape.circle,
            handle_border_color = beautiful.border_color,
            handle_border_width = 1,
            value               = 25,
            widget              = wibox.widget.slider,
          },      
          {
            text   = 'foobar',
            widget = wibox.widget.textbox
          },
          layout = wibox.layout.align.vertical,
        },
        layout = wibox.layout.align.vertical,
    },
    margins = 10,
    forced_width = dpi(355),
    widget  = wibox.container.margin
  },
  placement = function(c)
    (awful.placement.right + awful.placement.maximize_vertically)(c)
  end,
  shape        = gears.shape.rectangle,
  height       = 1500,
  width        = 1500,
  visible      = false,
  ontop        = true,
}

Q.panel.toggle = function()
  if panel.visible == false then
    panel.visible = true
    panel.screen = awful.screen.focused()
  elseif panel.screen.index ~= awful.screen.focused().index then
    panel.screen = awful.screen.focused()
  else
    panel.visible = false
  end
end
