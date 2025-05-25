{
  config,
  pkgs,
  ...
}: {
  fileSystems."/mnt/data" = {
    device = "10.0.0.5:/mnt/user/data";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "nfsvers=4" # or try nfsvers=3 if v4 fails
      "rsize=8192"
      "wsize=8192"
      "timeo=14"
      "soft"
    ];
  };
}
