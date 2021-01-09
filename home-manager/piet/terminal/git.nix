{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Piet de Vries";
    userEmail = "piet@compenda.nl";
    extraConfig= {
      pull.rebase = true;
    };

    signing.signByDefault = true;
  };
}
