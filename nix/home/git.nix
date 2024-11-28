{pkgs, ...}: {
  enable = true;

  lfs.enable = true;

  userName = "Chris Rickard";
  userEmail = "103567821+rickardc@users.noreply.github.com";
  #signing.key = null;
  #signing.signByDefault = true;

  extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
  };

  ignores = [
    "*.DS_Store"
    "*.log"
  ];
}
