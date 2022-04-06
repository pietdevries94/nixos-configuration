---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local variables = require("variables")

local theme = {}

theme.font_name     = "sans"
theme.font          = theme.font_name .. " 8"

theme.bg_normal     = variables.colors.background
theme.bg_subtle     = variables.colors.backgroundAlt
theme.bg_focus      = variables.colors.accentAlt
theme.bg_urgent     = variables.colors.secondaryAccent
theme.bg_minimize   = variables.colors.backgroundAlt
theme.bg_systray    = variables.colors.background

theme.fg_normal     = variables.colors.foreground
theme.fg_focus      = variables.colors.foregroundAlt
theme.fg_urgent     = variables.colors.foregroundAlt
theme.fg_minimize   = variables.colors.foregroundAlt
theme.fg_accent     = variables.colors.accentAlt

theme.useless_gap   = dpi(8)
theme.border_width  = dpi(0)
theme.border_normal = variables.colors.backgroundAlt
theme.border_focus  = variables.colors.accentAlt
theme.border_marked = variables.colors.secondaryAccent

theme.titlebar_bg_normal = variables.colors.accentAlt
theme.titlebar_bg_focus  = variables.colors.accentAlt

theme.taglist_bg_empty = theme.bg_subtle
theme.taglist_bg_occupied = theme.bg_subtle

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
theme.taglist_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
end


local taglist_square_size = dpi(6)
local taglist_square_shape = function(cr, width, height)
    gears.shape.partially_rounded_rect(cr, width, height, false, false, true, false, 5)
end
theme.taglist_squares_sel = gears.surface.load_from_shape(taglist_square_size, taglist_square_size, taglist_square_shape, variables.colors.accent)
theme.taglist_squares_unsel = gears.surface.load_from_shape(taglist_square_size, taglist_square_size, taglist_square_shape, variables.colors.tertiaryAccent)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = gears.surface.load_from_shape(dpi(30), dpi(30), gears.shape.circle, variables.colors.accent)
theme.titlebar_close_button_focus  = gears.surface.load_from_shape(dpi(30), dpi(30), gears.shape.circle, variables.colors.accent)

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

theme.wallpaper = "/home/piet/.background-image.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- bling tag preview
theme.tag_preview_client_opacity = 1
theme.tag_preview_client_bg = variables.colors.background
theme.tag_preview_widget_border_color = variables.colors.backgroundAlt
theme.tag_preview_widget_border_width = 0
theme.tag_preview_client_border_width = 0
theme.tag_preview_widget_bg = variables.colors.backgroundAlt

-- sliders
theme.slider_bar_border_width = 0
theme.slider_handle_border_width = 0
theme.slider_handle_width = dpi(14)
theme.slider_handle_shape = gears.shape.circle
theme.slider_handle_color = variables.colors.accent
theme.slider_bar_shape = gears.shape.rounded_rect
theme.slider_bar_height = dpi(2)
theme.slider_bar_color = variables.colors.accentAlt

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80