{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.hardware.input;

  myCustomLayout = pkgs.writeText "xkb-layout" ''
    clear lock
    clear mod3
    clear mod4
    keycode 66 = Hyper_L
    add mod3 = Hyper_L
    add mod4 = Super_L Super_R
  '';
  
  restartXmodmapService = pkgs.writeScript "restartXmodmapService.sh" ''#!${pkgs.bash}/bin/bash
    echo "" > /tmp/keyboard-piet.lock
    chown piet /tmp/keyboard-piet.lock
  '';
  xmodmapExecStart = pkgs.writeScript "xmodmapExecStart.sh" ''#!${pkgs.bash}/bin/bash
    ${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout} &
  '';
  xsessionInitKeyboardScript = pkgs.writeScript "xsessionInitKeyboard.sh" ''#!${pkgs.bash}/bin/bash
    ${pkgs.inotify-tools}/bin/inotifywait -m /tmp -e create -e moved_to |
    while read path action file; do
        if [[ "$file" = "keyboard-piet.lock" ]]; then
            sleep 1
            systemctl --user restart xmodmap.service
            rm -f /tmp/keyboard-piet.lock
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
    '';

    # Needed for live training
    users = {
      groups.plugdev = {};
      users.piet.extraGroups = [ "plugdev" ];
    };

    home-manager.users.piet = {
      systemd.user.services.xmodmap = {
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

      xsession.initExtra = ''
        ${xsessionInitKeyboardScript} &
      '';

      # Flash tool for moonlander
      home.packages = with pkgs; [
        wally-cli
      ];
      programs.zsh.initExtra = ''
        mnfl () { wally-cli $1 && rm $1 }
      '';
    };
  };
}
