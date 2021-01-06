{ pkgs, ... }:

{
  systemd.user.services.mailhog = {
    Unit = {
      Description = "MailHog service";
    };
    Service = {
      ExecStart = "${pkgs.mailhog}/bin/MailHog";
    };
  };
}