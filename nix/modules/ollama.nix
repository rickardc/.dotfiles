{...}: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    rocmOverrideGfx = "10.3.1";
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      openwebui = {
        image = "ghcr.io/open-webui/open-webui:latest";
        ports = ["8080:8080"];
        volumes = ["open-webui:/app/backend/data"];
        extraOptions = ["--network=host"];
      };
    };
  };
}
