{pkgs, ...}: {
  # Use OCI containers as systemd services
  virtualisation.oci-containers = {
    backend = "docker"; # Use Docker as the container runtime
    containers = {
      openwebui = {
        # Container configuration for Ollama Web UI
        image = "ghcr.io/open-webui/open-webui:main"; # Replace with the correct image for Ollama Web UI
        autoStart = true; # Ensure the container starts automatically
        ports = ["8080:8080"]; # Expose the web UI on port 8080
        volumes = ["open-webui:/app/backend/data"]; # Mount appropriate volumes (if needed)
        extraOptions = ["--network=host"];
        environment = {
        };
      };
    };
  };
}
