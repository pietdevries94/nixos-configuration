{...}:

# To make this work, you need to make a the volume
# mkdir -p /srv/container-volumes/mssql-2017

{
  virtualisation.oci-containers.containers.mssql-2017 = {
    autoStart = false;
    image = "mcr.microsoft.com/mssql/server:2017-latest";
    ports = [
      "14017:1433"
    ];
    environment = {
      ACCEPT_EULA = "Y";
      SA_PASSWORD = "yourStrong(!)Password";
    };
    volumes = [
      "/srv/container-volumes/mssql-2017:/var/opt/mssql"
    ];
  };
}