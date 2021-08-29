{ colors }:
{ config, pkgs, lib, ... }:

{
  xsession.windowManager.bspwm = {
    enable = true;

    monitors = {
      HDMI-A-0 = [ "1" "2" "3" "4" "5" "6" "7" ];
      HDMI-0 = [ "8" "9" "0" ];
      eDP = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" ];
      DVI-D-0 = [ "8" "9" "0"];
      DisplayPort-0 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" ];
    };

    settings = {
      # gaps
      window_gap = 20;

      # pointer settings
      focus_follows_pointer = true;
      pointer_modifier = "mod3";
      pointer_action1 = "move";
      pointer_action2 = "resize_corner";
      normal_border_color = colors.ui.tertiaryAccent;
      active_border_color = colors.ui.secondaryAccentAlt;
      focused_border_color = colors.ui.secondaryAccent;

      # needed for monitor change
      remove_disabled_monitors = true;
      remove_unplugged_monitors = true;
    };

    startupPrograms = [
      "bspc wm -O HDMI-A-0 DVI-D-0"
      "xsetroot -cursor_name left_ptr"
    ];
  };

  services.sxhkd.keybindings = {
    # quit/restart bspwm
    # "mod3 + mod1 + {q,r}" =	"bspc {quit,wm -r}";

    # close and kill
    "mod3 + {_,mod1 + }w" = "bspc node -{c,k}";

    # alternate between the tiled and monocle layout
    "mod3 + m" = "bspc desktop -l next";

    # swap the current node and the biggest window
    "mod3 + g" = "bspc node -s biggest.window";

    # set the window state
    "mod3 + {t,mod1 + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";

    # focus the node in the given direction
    "mod3 + {h,j,k,l}" = "bspc node -f {west,south,north,east}";

    # move the node in the given direction
    "mod3 + mod1 + {h,j,k,l}" = "${./bspwm_smart_move.sh} {west,south,north,east}";

    # focus the node for the given path jump
    "mod3 + {p,b,comma,period}" = "bspc node -f @{parent,brother,first,second}";
    
    # focus the next/previous window in the current desktop
    "mod3 + bracket{left,right}" = "bspc desktop -f {prev,next}.local";

    # focus the last node/desktop
    "mod3 + {grave,Tab}" = "bspc {node,desktop} -f last";

    # focus or send to the given desktop
    "mod3 + {1-9,0}" = "bspc desktop -f '^{1-9,10}'";
    "mod3 + mod1 + {1-9,0}" = "bspc node -d '^{1-9,10}' --follow";

    # expand a window by moving one of its side outward
    "mod3 + mod4 + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";

    # contract a window by moving one of its side inward
    "mod3 + mod4 + mod1 + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";

    # move a floating window
    "mod3 + {Left,Down,Up,Right}" =	"bspc node -v {-20 0,0 20,0 -20,20 0}";

    # Goto next workspace
    "ctrl + {Left,Right}" =	"bspc desktop -f {prev,next}";
  };
}