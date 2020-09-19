{ colors, writeText, scriptIcons }:

writeText "tint2rc" ''
#---- Generated by tint2conf 2bea ----
# See https://gitlab.com/o9000/tint2/wikis/Configure for 
# full documentation of the configuration options.
#-------------------------------------
# Gradients
# Gradient 1
gradient = vertical
start_color = ${colors.ui.tertiaryAccent} 100
end_color = ${colors.ui.secondaryAccent} 100

# Gradient 2
gradient = vertical
start_color = ${colors.ui.tertiaryAccent} 88
end_color = ${colors.ui.secondaryAccent} 88

#-------------------------------------
# Backgrounds
# Background 1: Active task
rounded = 6
border_width = 0
border_sides = 
border_content_tint_weight = 0
background_content_tint_weight = 0
background_color = ${colors.ui.foreground} 100
border_color = ${colors.ui.foregroundAlt} 40
background_color_hover = ${colors.ui.foreground} 78
border_color_hover = ${colors.ui.foregroundAlt} 40
background_color_pressed = ${colors.ui.foreground} 100
border_color_pressed = ${colors.ui.foregroundAlt} 78

# Background 2: Default task
rounded = 6
border_width = 0
border_sides = 
border_content_tint_weight = 0
background_content_tint_weight = 0
background_color = ${colors.ui.foreground} 39
border_color = ${colors.ui.foregroundAlt} 40
gradient_id = 0
background_color_hover = ${colors.ui.foreground} 88
border_color_hover = ${colors.ui.foregroundAlt} 40
background_color_pressed = ${colors.ui.foreground} 39
border_color_pressed = ${colors.ui.foregroundAlt} 78

# Background 3: Active desktop name, Inactive desktop name, Urgent task
rounded = 6
border_width = 0
border_sides = 
border_content_tint_weight = 0
background_content_tint_weight = 0
background_color = ${colors.ui.foreground} 100
border_color = ${colors.ui.foregroundAlt} 40
gradient_id = 0
background_color_hover = ${colors.ui.foreground} 88
border_color_hover = ${colors.ui.foregroundAlt} 40
background_color_pressed = ${colors.ui.foreground} 100
border_color_pressed = ${colors.ui.foregroundAlt} 78

# Background 4: Active taskbar, Clock, Inactive taskbar, Panel
rounded = 0
border_width = 0
border_sides = 
border_content_tint_weight = 0
background_content_tint_weight = 0
background_color = ${colors.ui.accent} 100
border_color = ${colors.ui.background} 0
background_color_hover = ${colors.ui.background} 0
border_color_hover = ${colors.ui.background} 0
background_color_pressed = ${colors.ui.background} 0
border_color_pressed = ${colors.ui.background} 0

# Background 5: 
rounded = 6
border_width = 0
border_sides = 
border_content_tint_weight = 0
background_content_tint_weight = 0
background_color = ${colors.ui.foreground} 0
border_color = ${colors.ui.foregroundAlt} 0
gradient_id = 1
background_color_hover = ${colors.ui.tertiaryAccent} 0
border_color_hover = ${colors.ui.foregroundAlt} 0
gradient_id_hover = 2
background_color_pressed = ${colors.ui.tertiaryAccent} 0
border_color_pressed = ${colors.ui.foregroundAlt} 0
gradient_id_pressed = 1

# Background 6: 
rounded = 6
border_width = 0
border_sides = 
border_content_tint_weight = 0
background_content_tint_weight = 0
background_color = ${colors.ui.foreground} 0
border_color = ${colors.ui.foregroundAlt} 0
background_color_hover = ${colors.ui.foreground} 10
border_color_hover = ${colors.ui.foregroundAlt} 0
background_color_pressed = ${colors.ui.foreground} 0
border_color_pressed = ${colors.ui.foregroundAlt} 0

# Background 7: Tooltip
rounded = 0
border_width = 0
border_sides = 
border_content_tint_weight = 0
background_content_tint_weight = 0
background_color = ${colors.ui.accent} 100
border_color = ${colors.ui.background} 0
background_color_hover = ${colors.ui.background} 0
border_color_hover = ${colors.ui.background} 0
background_color_pressed = ${colors.ui.background} 0
border_color_pressed = ${colors.ui.background} 0

# Background 8: Executor, Systray
rounded = 14
border_width = 0
border_sides = 
border_content_tint_weight = 0
background_content_tint_weight = 0
background_color = ${colors.ui.background} 100
border_color = ${colors.ui.foregroundAlt} 0
background_color_hover = ${colors.ui.background} 100
border_color_hover = ${colors.ui.foregroundAlt} 0
background_color_pressed = ${colors.ui.background} 100
border_color_pressed = ${colors.ui.foregroundAlt} 0

#-------------------------------------
# Panel
panel_items = PEEEETSC
panel_size = 100% 45
panel_margin = 0 0
panel_padding = 7 7 7
panel_background_id = 4
wm_menu = 1
panel_dock = 0
panel_pivot_struts = 0
panel_position = center left vertical
panel_layer = top
panel_monitor = 1
panel_shrink = 0
autohide = 0
autohide_show_timeout = 0
autohide_hide_timeout = 0
autohide_height = 1
strut_policy = follow_size
panel_window_name = tint2
disable_transparency = 0
mouse_effects = 1
font_shadow = 0
mouse_hover_icon_asb = 99 0 10
mouse_pressed_icon_asb = 100 0 0
scale_relative_to_dpi = 0
scale_relative_to_screen_height = 0

#-------------------------------------
# Taskbar
taskbar_mode = single_desktop
taskbar_hide_if_empty = 0
taskbar_padding = 8 9 7
taskbar_background_id = 4
taskbar_active_background_id = 4
taskbar_name = 1
taskbar_hide_inactive_tasks = 0
taskbar_hide_different_monitor = 0
taskbar_hide_different_desktop = 0
taskbar_always_show_all_desktop_tasks = 0
taskbar_name_padding = 0 0
taskbar_name_background_id = 3
taskbar_name_active_background_id = 3
taskbar_name_font = Iosevka 8
taskbar_name_font_color = ${colors.ui.accent} 100
taskbar_name_active_font_color = ${colors.ui.accent} 100
taskbar_distribute_size = 0
taskbar_sort_order = title
task_align = right

#-------------------------------------
# Task
task_text = 1
task_icon = 0
task_centered = 1
urgent_nb_of_blink = 3
task_maximum_size = 10 13
task_padding = 0 0 0
task_font = Sans 0
task_tooltip = 1
task_thumbnail = 1
task_thumbnail_size = 210
task_background_id = 2
task_active_background_id = 1
task_urgent_background_id = 3
mouse_left = toggle_iconify
mouse_middle = none
mouse_right = close
mouse_scroll_up = next_task
mouse_scroll_down = prev_task

#-------------------------------------
# System tray (notification area)
systray_padding = 8 0 10
systray_background_id = 8
systray_sort = ascending
systray_icon_size = 16
systray_icon_asb = 100 0 10
systray_monitor = 1
systray_name_filter = 

#-------------------------------------
# Launcher
launcher_padding = 8 4 4
launcher_background_id = 0
launcher_icon_background_id = 0
launcher_icon_size = 16
launcher_icon_asb = 100 0 0
launcher_icon_theme_override = 0
startup_notifications = 0
launcher_tooltip = 0

#-------------------------------------
# Clock
time1_format = %H %M
time2_format = 
time1_font = Iosevka Bold 15
time1_timezone = 
time2_timezone = 
time2_font = Iosevka Italic 10
clock_font_color = ${colors.ui.foreground} 100
clock_padding = 0 7
clock_background_id = 4
clock_tooltip = %A, %d %B %Y
clock_tooltip_timezone = 
clock_lclick_command = gsimplecal
clock_rclick_command = gsimplecal
clock_mclick_command = 
clock_uwheel_command = 
clock_dwheel_command = 

#-------------------------------------
# Battery
battery_tooltip = 1
battery_low_status = 0
battery_low_cmd = 
battery_full_cmd = 
battery_font_color = ${colors.ui.background} 100
bat1_format = 
bat2_format = 
battery_padding = 0 0
battery_background_id = 0
battery_hide = 101
battery_lclick_command = 
battery_rclick_command = 
battery_mclick_command = 
battery_uwheel_command = 
battery_dwheel_command = 
ac_connected_cmd = 
ac_disconnected_cmd = 

#-------------------------------------
# Executor 1
execp = new
execp_command = ~/.config/tint2/executor/volume.sh
execp_interval = 1
execp_has_icon = 0
execp_cache_icon = 0
execp_continuous = 0
execp_markup = 0
execp_tooltip = 
execp_lclick_command = ~/.config/tint2/scripts/change-volume.sh mute ${scriptIcons.outputVolume}
execp_rclick_command = pavucontrol -t 3
execp_mclick_command = 
execp_uwheel_command = ~/.config/tint2/scripts/change-volume.sh up ${scriptIcons.outputVolume}
execp_dwheel_command = ~/.config/tint2/scripts/change-volume.sh down ${scriptIcons.outputVolume}
execp_font = Font Awesome 5 Free 12
execp_font_color = ${colors.ui.foreground} 100
execp_padding = 8 0
execp_background_id = 8
execp_centered = 1
execp_icon_w = 0
execp_icon_h = 0

#-------------------------------------
# Executor 2
execp = new
execp_command = ~/.config/tint2/executor/microphone.sh
execp_interval = 1
execp_has_icon = 0
execp_cache_icon = 0
execp_continuous = 0
execp_markup = 0
execp_tooltip = 
execp_lclick_command = ~/.config/tint2/scripts/change-microphone.sh mute ${scriptIcons.inputVolume}
execp_rclick_command = pavucontrol -t 4
execp_mclick_command = 
execp_uwheel_command = ~/.config/tint2/scripts/change-microphone.sh up ${scriptIcons.inputVolume}
execp_dwheel_command = ~/.config/tint2/scripts/change-microphone.sh down ${scriptIcons.inputVolume}
execp_font = Font Awesome 5 Free 12
execp_font_color = ${colors.ui.foreground} 100
execp_padding = 8 0
execp_background_id = 8
execp_centered = 1
execp_icon_w = 0
execp_icon_h = 0

#-------------------------------------
# Executor 3
execp = new
execp_command = ~/.config/tint2/executor/brightness.sh
execp_interval = 0
execp_has_icon = 0
execp_cache_icon = 0
execp_continuous = 0
execp_markup = 0
execp_tooltip = 
execp_lclick_command = ~/.config/tint2/scripts/change-brightness.sh ${scriptIcons.brightness}
execp_rclick_command = 
execp_mclick_command = 
execp_uwheel_command = 
execp_dwheel_command = 
execp_font = Font Awesome 5 Free 12
execp_font_color = ${colors.ui.foreground} 100
execp_padding = 8 0
execp_background_id = 8
execp_centered = 1
execp_icon_w = 0
execp_icon_h = 0

#-------------------------------------
# Executor 4
execp = new
execp_command = ~/.config/tint2/executor/headphones.sh
execp_interval = 0
execp_has_icon = 0
execp_cache_icon = 0
execp_continuous = 0
execp_markup = 0
execp_tooltip = 
execp_lclick_command = ~/.config/tint2/scripts/toggle-headphones.sh
execp_rclick_command = 
execp_mclick_command = 
execp_uwheel_command = 
execp_dwheel_command = 
execp_font = Font Awesome 5 Free 12
execp_font_color = ${colors.ui.foreground} 100
execp_padding = 8 0
execp_background_id = 8
execp_centered = 1
execp_icon_w = 0
execp_icon_h = 0

#-------------------------------------
# Button 1
button = new
button_text = 
button_lclick_command = ~/.config/tint2/scripts/power-menu.sh
button_rclick_command = 
button_mclick_command = 
button_uwheel_command = 
button_dwheel_command = 
button_font = Font Awesome 5 Free 12
button_font_color = ${colors.ui.foreground} 100
button_padding = 8 0
button_background_id = 8
button_centered = 1
button_max_icon_size = 0

#-------------------------------------
# Tooltip
tooltip_show_timeout = 0.5
tooltip_hide_timeout = 0.2
tooltip_padding = 8 6
tooltip_background_id = 7
tooltip_font_color = ${colors.ui.foreground} 100
tooltip_font = Cantarell 8.5
''