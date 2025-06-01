{
  config,
  pkgs,
  lib,
  ...
}: {
  ## PostgreSQL server setup
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    settings.listen_addresses = lib.mkForce "*";
    initialScript = pkgs.writeText "init.sql" ''
      CREATE ROLE admin WITH LOGIN PASSWORD 'admin' CREATEDB;
      CREATE DATABASE mydb OWNER admin;
    '';
    authentication = ''
      host all all 127.0.0.1/32 md5
      host all all ::1/128 md5
    '';
  };

  ## pgAdmin 4 web interface setup
  services.pgadmin = {
    enable = true;
    port = 5050;
    initialEmail = "admin@example.com";
    initialPasswordFile = "/etc/pgadmin-pass"; # See note below
    openFirewall = true; # Expose port on LAN
    settings = {
    };
  };

  ## Store the pgAdmin password securely
  environment.etc."pgadmin-pass".text = "password";

  ## Optionally expose PostgreSQL as well (e.g. for remote access)
  networking.firewall.allowedTCPPorts = [5050 5432 8088];

  virtualisation.podman.enable = true;

  virtualisation.oci-containers = {
    backend = "podman";

    containers = {
      superset = {
        serviceName = "Superset";
        image = "docker.io/apache/superset";
        networks = ["host"]; # use host networking so it can access local postgres
        ports = [
          "8088:8088" # expose Superset UI
        ];
        environment = {
          # Allowing python to print() in docker
          PYTHONUNBUFFERED = "1";
          DEV_MODE = "true";
          SUPERSET_SECRET_KEY = "mysecretkey";
          DATABASE_PORT = "5432";
          DATABASE_DIALECT = "postgresql";
          DATABASE_URL = "postgresql://admin:admin@127.0.0.1:5432/mydb";
        };
        volumes = [
          "/var/lib/superset:/app/superset_home"
        ];
        autoStart = true;
      };
    };
  };
}
