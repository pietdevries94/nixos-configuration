{ wallpaper }:
{ config, pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod3";
      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
        ws1 = "1";
        ws2 = "2";
        ws3 = "3";
        ws4 = "4";
        ws5 = "5";
        ws6 = "6";
        ws7 = "7";
        ws8 = "8";
        ws9 = "9";
        ws10 = "10";
      in {
        "${modifier}+Return" = "exec --no-startup-id kitty";
        "${modifier}+Mod4+q" = "kill";
        "Mod4+space" = "exec ${pkgs.rofi}/bin/rofi -show drun -modi drun";

        # change focus
        "${modifier}+j" = "focus left";
        "${modifier}+k" = "focus down";
        "${modifier}+i" = "focus up";
        "${modifier}+l" = "focus right";

        # alternatively, you can use the cursor keys:
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        # move focused window
        "${modifier}+Mod4+j" = "move left";
        "${modifier}+Mod4+k" = "move down";
        "${modifier}+Mod4+i" = "move up";
        "${modifier}+Mod4+l" = "move right";

        # alternatively, you can use the cursor keys:
        "${modifier}+Mod4+Left" = "move left";
        "${modifier}+Mod4+Down" = "move down";
        "${modifier}+Mod4+Up" = "move up";
        "${modifier}+Mod4+Right" = "move right";

        # split in horizontal orientation
        "${modifier}+h" = "split h";

        # split in vertical orientation
        "${modifier}+v" = "split v";

        # enter fullscreen mode for the focused container
        "${modifier}+f" = "fullscreen toggle";

        # change container layout (stacked, tabbed, toggle split)
        "${modifier}+Shift+s" = "layout stacking";
        "${modifier}+Shift+w" = "layout tabbed";
        "${modifier}+Shift+e" = "layout toggle split";

        # toggle tiling / floating
        "${modifier}+Mod4+space" = "floating toggle";

        # change focus between tiling / floating windows
        "${modifier}+Mod4" = "focus mode_toggle";

        # focus the parent container
        "${modifier}+Mod4+a" = "focus parent";

        # focus the child container
        "${modifier}+Mod4+d" = "focus child";

        # switch to workspace
        "${modifier}+1" = "workspace ${ws1}";
        "${modifier}+2" = "workspace ${ws2}";
        "${modifier}+3" = "workspace ${ws3}";
        "${modifier}+4" = "workspace ${ws4}";
        "${modifier}+5" = "workspace ${ws5}";
        "${modifier}+6" = "workspace ${ws6}";
        "${modifier}+7" = "workspace ${ws7}";
        "${modifier}+8" = "workspace ${ws8}";
        "${modifier}+9" = "workspace ${ws9}";
        "${modifier}+0" = "workspace ${ws10}";
        "control+Left" = "workspace prev";
        "control+Right" = "workspace next";

        # move focused container to workspace
        "${modifier}+Mod4+1" = "move container to workspace ${ws1}; workspace ${ws1}";
        "${modifier}+Mod4+2" = "move container to workspace ${ws2}; workspace ${ws2}";
        "${modifier}+Mod4+3" = "move container to workspace ${ws3}; workspace ${ws3}";
        "${modifier}+Mod4+4" = "move container to workspace ${ws4}; workspace ${ws4}";
        "${modifier}+Mod4+5" = "move container to workspace ${ws5}; workspace ${ws5}";
        "${modifier}+Mod4+6" = "move container to workspace ${ws6}; workspace ${ws6}";
        "${modifier}+Mod4+7" = "move container to workspace ${ws7}; workspace ${ws7}";
        "${modifier}+Mod4+8" = "move container to workspace ${ws8}; workspace ${ws8}";
        "${modifier}+Mod4+9" = "move container to workspace ${ws9}; workspace ${ws9}";
        "${modifier}+Mod4+0" = "move container to workspace ${ws10}; workspace ${ws10}";

        # move focussed workspace to monitor
        "${modifier}+Mod4+u" = "move workspace to output left";
        "${modifier}+Mod4+o" = "move workspace to output right";

        # reload the configuration file
        "${modifier}+Mod4+c" = "reload";
        # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
        "${modifier}+Mod4+r" = "restart";
        # exit i3 (logs you out of your X session)
        "${modifier}+Mod4+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'\"";

        # Resizing windows by 10 in i3 using keyboard only
        "${modifier}+a" = "resize shrink width 3 px or 3 ppt";
        "${modifier}+w" = "resize grow height 3 px or 3 ppt";
        "${modifier}+s" = "resize shrink height 3 px or 3 ppt";
        "${modifier}+d" = "resize grow width 3 px or 3 ppt";
      };

      window.border = 0;
      floating.border = 0;

      gaps = {
        inner = 16;
        outer = 0;
        bottom = 34;
      };

      bars = [];

      startup = [
        { command = "${pkgs.feh}/bin/feh --bg-fill ~/.background-image.png"; always = true; notification = false; }
      ];
    };
  };

  home.file.".background-image.png".source = wallpaper;
}