{ config, pkgs, lib, ... }:

{
  gtk = {
    enable = true;

    theme = {
      package = pkgs.qogir-theme;
      name = "Qogir Light";
    };
    iconTheme = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
    };
  };
}
