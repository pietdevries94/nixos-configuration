{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.hardware.input;

  xmodmap-layout = pkgs.writeText "xmodmap-layout" ''
    clear lock
    clear mod3
    clear mod4
    keycode 66 = Hyper_L
    add mod3 = Hyper_L
    add mod4 = Super_L Super_R
  '';

  xmodmapExecStart = pkgs.writeScript "xmodmapExecStart.sh" ''#!${pkgs.bash}/bin/bash
    ${pkgs.xorg.xmodmap}/bin/xmodmap ${xmodmap-layout} &
  '';

  restartXmodmapService = pkgs.writeScript "restartXmodmapService.sh" ''#!${pkgs.bash}/bin/bash
    mkdir -p /tmp/reload-locks
    echo "" > /tmp/reload-locks/reload-keyboard-piet.lock
    chown -R piet /tmp/reload-locks
  '';

  restartLibinputGesturesService = pkgs.writeScript "restartLibinputGesturesService.sh" ''#!${pkgs.bash}/bin/bash
    mkdir -p /tmp/reload-locks
    echo "" > /tmp/reload-locks/reload-libinput-gestures-piet.lock
    chown -R piet /tmp/reload-locks
  '';

  watchReloadFiles = pkgs.writeScript "watchReloadFiles.sh" ''#!${pkgs.bash}/bin/bash
    mkdir -p /tmp/reload-locks
    ${pkgs.inotify-tools}/bin/inotifywait -m /tmp/reload-locks -e create -e moved_to |
    while read path action file; do
        if [[ "$file" = "reload-keyboard-piet.lock" ]]; then
            sleep 1
            systemctl --user restart xmodmap.service
            rm -f /tmp/reload-locks/reload-keyboard-piet.lock
        fi
        if [[ "$file" = "reload-libinput-gestures-piet.lock" ]]; then
            sleep 1
            systemctl --user restart libinput-gestures.service
            rm -f /tmp/reload-locks/reload-libinput-gestures-piet.lock
        fi
    done
  '';
in {
  options.custom.hardware.input = {
    enable = mkEnableOption "Keyboard, touchpad and mouse settings";
  };

  config = mkIf cfg.enable {
    services.udev.extraRules = ''
      # Moonlander live training
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"

      # Moonlander live flashing
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", \
        MODE:="0666", \
        SYMLINK+="stm32_dfu"

      # Moonlander connect event
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", RUN+="${restartXmodmapService}"
      
      # Magic Trackpad connect event
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="05ac", ATTR{idProduct}=="0265", RUN+="${restartLibinputGesturesService}"
    '';

    # Needed for live training
    users = {
      groups.plugdev = {};
      users.piet.extraGroups = [ "plugdev" ];
    };

    home-manager.users.piet = {
      systemd.user.services = {
        xmodmap = {
          Unit = {
            Description = "Set xmodmap oneshot service";
            After = [ "graphical-session-pre.target" ];
            PartOf = [ "graphical-session.target" ];
          };

          Install = { WantedBy = [ "graphical-session.target" ]; };

          Service = {
            Type = "oneshot";
            Environment = "DISPLAY=:0";
            RemainAfterExit = "yes";
            ExecStart = "${xmodmapExecStart}";
          };
        };
        libinput-gestures = {
          Unit = {
            Description = "Set libinput-gestures service";
            After = [ "graphical-session-pre.target" ];
            PartOf = [ "graphical-session.target" ];
          };

          Install = { WantedBy = [ "graphical-session.target" ]; };

          Service = {
            Type = "simple";
            RemainAfterExit = "yes";
            ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
          };
        };
      };

      home.file.".config/libinput-gestures.conf".source = pkgs.writeText "libinput-gestures.conf" ''
gesture swipe down	3 xdotool key ctrl+r

# Front and back
gesture swipe left	3 xdotool key alt+Right
gesture swipe right	3 xdotool key alt+Left

# Notifications
gesture swipe up	  4 xdotool key ctrl+space
gesture swipe down	4 xdotool key ctrl+Escape
gesture swipe left	4 xdotool key ctrl+Right
gesture swipe right	4 xdotool key ctrl+Left

# Zoom in and out
gesture pinch in	xdotool key ctrl+equal
gesture pinch out	xdotool key ctrl+minus
'';

      xsession.initExtra = ''
        ${watchReloadFiles} &
      '';

      home.packages = with pkgs; [
        xdotool
        # Flash tool for moonlander
        wally-cli
      ];
      programs.zsh.initExtra = ''
        mnfl () { wally-cli $1 && rm $1 }
      '';
    };
  };
}
