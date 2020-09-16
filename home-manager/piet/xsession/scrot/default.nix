{...}:

{
  services.sxhkd.keybindings = {
    "mod1 + shift + 3" = "${./screenshot.sh} full";
    "mod1 + shift + 4" = "${./screenshot.sh} selection";
  };
}