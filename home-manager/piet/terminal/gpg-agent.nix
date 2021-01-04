{ ... }:

{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 500;
    defaultCacheTtlSsh = 500;
  };
}