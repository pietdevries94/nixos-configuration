{ ... }:

{
  imports = [ ./minimal.nix ];

  custom.user.programs = {
    alacritty.enable = true;
  };
}