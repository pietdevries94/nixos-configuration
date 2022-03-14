local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local tag_preview = require("modules.bling.widget.tag_preview")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
                              if client.focus then
                                  client.focus:move_to_tag(t)
                              end
                          end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
                              if client.focus then
                                  client.focus:toggle_tag(t)
                              end
                          end),
    awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
)

local bar_buttons = gears.table.join(
  awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
)

tag_preview.enable {
  show_client_content = true,
  x = dpi(40),
  y = dpi(8),
  background_widget = wibox.widget {    -- Set a background image (like a wallpaper) for the widget 
    image = beautiful.wallpaper,
    horizontal_fit_policy = "fit",
    vertical_fit_policy   = "fit",
    widget = wibox.widget.imagebox
  }
}

local function taggies(s)
  return awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    layout = { spacing = dpi(5), layout = wibox.layout.fixed.vertical },
    buttons = taglist_buttons,
    widget_template = {
      {
        {
          id = "text_role",
          widget = wibox.widget.textbox,
          align = "center",
          valign = "center",
        },
        margins = dpi(4),
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
      create_callback = function(self, c3, index, objects)
        self:connect_signal("mouse::enter", function()
          if #c3:clients() > 0 then
            awesome.emit_signal("bling::tag_preview::update", c3)
            awesome.emit_signal("bling::tag_preview::visibility", s, true)
          end
        end)
        self:connect_signal("mouse::leave", function()
          awesome.emit_signal("bling::tag_preview::visibility", s, false)

          if self.has_backup then
            self.bg = self.backup
          end
        end)
      end,
    }
  }
end

local time = wibox.widget {
  widget = wibox.container.background,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  bg = beautiful.bg_subtle,
  {
    widget = wibox.container.margin,
    bottom = dpi(4),
    top = dpi(4),
    {
      layout = wibox.layout.fixed.vertical,
      {
        widget = wibox.widget.textclock "%H",
        font = beautiful.font_name .. " Bold 8",
        align = "center",
      },
      {
        widget = wibox.widget.textclock "%M",
        font = beautiful.font_name .. " Bold 8",
        align = "center",
      },
    },
  },
}

local time_t = awful.tooltip {
  objects = { time },
  delay_show = 1,
  timer_function = function()
    return os.date "%A %B %d %Y"
  end,
}

local tray = wibox.widget.systray()
tray.horizontal = false

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[2])

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "left", screen = s, width = dpi(32) })

    -- Add widgets to the wibox
    s.mywibox:setup {
      widget = wibox.container.margin,
      margins = dpi(5),
      {
        layout = wibox.layout.align.vertical,
        {
            layout = wibox.layout.fixed.vertical,
            taggies(s),
        },
        {
          layout = wibox.layout.fixed.vertical,
          buttons = bar_buttons,          
        },
        {
          tray,
          time,
          layout = wibox.layout.fixed.vertical,
        },
      }
    }
end)