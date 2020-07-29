{ config, pkgs, lib, ... }:

let
  extensions = (with pkgs.vscode-extensions; [
      bbenoist.Nix
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "nix-env-selector";
      publisher = "arrterian";
      version = "0.1.2";
      sha256 = "1n5ilw1k29km9b0yzfd32m8gvwa2xhh6156d4dys6l8sbfpp2cv9";
    }
    {
      name = "go";
      publisher = "golang";
      version = "0.15.2";
      sha256 = "0whd0a97fd9l1rzw93r1ijr2kzmasvals9rrp5lk1j9iybxv4mf2";
    }
  ];
in
{

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = extensions;
  };
}