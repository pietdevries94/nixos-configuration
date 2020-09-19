{ colors, scriptIcons }:
{ config, pkgs, lib, ... }:

let
  tint2rc = (import ./tint2rc.nix { inherit colors scriptIcons; inherit (pkgs) writeText; });
in {
  home.packages = with pkgs; [
    tint2
  ];

  home.file.".config/tint2/tint2rc".source = tint2rc;
  home.file.".config/tint2/scripts".source = ./scripts;
  home.file.".config/tint2/executor".source = ./executor;

  xsession.initExtra = ''
    tint2 &
    blueman-applet &
  '';
}
