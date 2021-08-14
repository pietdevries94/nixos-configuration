# TODO remove this import when base is completely ported

{ config, pkgs, options, lib, ... }:

{
  networking.firewall.allowedTCPPortRanges = [
    # KDE Connect
    {
      from = 1714;
      to = 1764;
    }
  ];
}
