{...}:

# To make this work, you need to make a the volume
# mkdir -p /srv/container-volumes/mssql-2019
# chown 10001 /srv/container-volumes/mssql-2019

{
  virtualisation.oci-containers.containers.mssql-2019 = {
    autoStart = false;
    image = "mcr.microsoft.com/mssql/server:2019-latest";
    ports = [
      "14019:1433"
    ];
    environment = {
      ACCEPT_EULA = "Y";
      SA_PASSWORD = "yourStrong(!)Password";
    };
    volumes = [
      "/srv/container-volumes/mssql-2019:/var/opt/mssql"
    ];
  };
}