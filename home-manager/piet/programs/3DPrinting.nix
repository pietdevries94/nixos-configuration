{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cura
    prusa-slicer
    meshlab
    blender
  ];
}