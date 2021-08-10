{ ... }:

{
  imports = [ ./minimal.nix ];

  programs.dconf.enable = true;

  custom.user.programs = {
    alacritty.enable = true;
  };
}