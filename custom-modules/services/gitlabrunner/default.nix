{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.services.gitlab-runner;
in {
  options.custom.services.gitlab-runner = {
    enable = mkEnableOption "gitlab runner";
  };

  config = mkIf cfg.enable {
    services.gitlab-runner = {
      enable = true;
      services= {
        # runner for building in docker via host's nix-daemon
        # nix store will be readable in runner, might be insecure
        general = {
          registrationConfigFile = toString /home/piet/.gitlab-runners/nix.registration;
          dockerImage = "nixpkgs/nix-flakes";
          dockerDisableCache = true;
          dockerPrivileged = true;
          dockerVolumes = [ "/tmp/:/hosttmp/" ];
          tagList = [ "linux" ];
        };
      };
    };
  };
}
