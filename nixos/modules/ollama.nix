{
  config,
  pkgs,
  ...
}: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    rocmOverrideGfx = "10.3.1";
    loadModels = ["deepseek-r1:8b" "qwen2.5-coder:14b"];
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
