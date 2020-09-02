{ colors, iconTheme }:
{ config, pkgs, lib, ... }:

{
  services.dunst = {
    enable = true;

    iconTheme = {
      inherit (iconTheme) package name;
      size = "96";
    };

    settings = {
      global = {
        title = "dunst";
        class = "dunst";
        monitor = 0;
        follow = "mouse";
        geometry = "350x6-24+24";
        indicate_hidden = "yes";
        shrink = "yes";

        transparency = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 13;
        frame_width = 8;
        frame_color = "#3b4252";
        separator_color = "#404859";

        font = "Cantarell 10";

        line_height = 0;
        markup = "full";
        format = "<span size='x-large' font_desc='Cantarell 9' weight='bold' foreground='#edfefe'>%s</span>\\n%b";
        alignment = "center";

        idle_threshold = 120;
        show_age_threshold = 60;
        sort = "no";
        word_wrap = "yes";
        ignore_newline = "no";
        stack_duplicates = false;
        hide_duplicate_count = "yes";
        show_indicators = "no";
        sticky_history = "no";
        history_length = 20;
        always_run_script = true;
        corner_radius = 0;
        icon_position = "left";
        max_icon_size = 96;

        browser = "firefox";

        mouse_left_click = "close_current";
        mouse_middle_click = "do_action";
        mouse_right_click = "close_all";
      };
      shortcuts = {
        close = "ctrl+Escape";
        close_all = "ctrl+shift+Escape";
        history = "ctrl+space";
      };

      urgency_low = {
        timeout = 5;
        background = "#3b4252";
        foreground = "#edfefe";
      };

      urgency_normal = {
        timeout = 10;
        background = "#3b4252";
        foreground = "#edfefe";
      };

      urgency_critical = {
        timeout = 0;
        background = "#3b4252";
        foreground = "#edfefe";
      };
    };
  };
}
