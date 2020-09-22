{ colors }:
{ pkgs, ... }:

{
  home.packages = [ pkgs.xautolock ];
  xsession.initExtra = ''
    ${pkgs.caffeine-ng}/bin/caffeine &
  '';
  
  services.screen-locker = {
    enable = true;
    inactiveInterval = 1;
    lockCmd = ''
      ${pkgs.i3lock-color}/bin/i3lock-color \
      -c ${colors.ui.background} \
      \
      --linecolor=${colors.ui.background}FF \
      --insidevercolor=${colors.ui.background}FF \
      --insidewrongcolor=${colors.ui.background}FF \
      --insidecolor=${colors.ui.background}FF \
      \
      --ringcolor=${colors.ui.foreground}FF \
      --keyhlcolor=${colors.ui.tertiaryAccent}FF \
      --bshlcolor=${colors.ui.tertiaryAccent}FF \
      --separatorcolor=${colors.ui.tertiaryAccent}FF \
      \
      --ringvercolor=${colors.ui.secondaryAccent}FF \
      --ringwrongcolor=${colors.ui.negative}FF \
      \
       --veriftext="" \
       --wrongtext="" \
       --noinputtext="" \
       --locktext="" \
       --lockfailedtext="" \
      -n
    '';
  };
} 