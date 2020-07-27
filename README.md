# NixOS configuration

This is my personal NixOS configuration. It's all WIP and I'm still learning Nix, but it's here.

I have a Nix Channel for some custom stuff, which I may try to upstream to nixpkgs in the future, if it's relevant and I'm more atunned to the best practices of Nix.
https://github.com/pietdevries94/personal-nix-channel

## Channels

This config uses the following channels
```bash
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
nix-channel --add https://github.com/rycee/home-manager/archive/release-20.03.tar.gz home-manager
nix-channel --add https://github.com/pietdevries94/personal-nix-channel/archive/master.tar.gz personal
nix-channel --update
```

## Credits

### Wallpaper
- avatar | [Original by John Staub](https://twitter.com/seewhatsnext/status/1042073279895224332) | [Upscaled wallpaper on Reddit](https://www.reddit.com/r/WidescreenWallpaper/comments/gh0qjr/appa_and_aang_in_the_south_pole_6480x2777/)