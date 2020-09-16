{ config, pkgs, ... }:

{
  home.file.".ssh/id_rsa".source = ../../../secrets/ssh/id_rsa;
  home.file.".ssh/id_rsa.pub".source = ../../../secrets/ssh/id_rsa.pub;
}
