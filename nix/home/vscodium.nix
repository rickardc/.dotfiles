{pkgs, ...}: {
  enable = true;
  package = pkgs.unstable.vscodium;

  extensions = with pkgs.unstable.vscode-extensions; [
    # vscodevim.vim
    bbenoist.nix
    ms-python.python
    ms-azuretools.vscode-docker
    ms-vscode-remote.remote-ssh
    ms-toolsai.jupyter
    ms-vscode.cpptools
    ms-vscode-remote.remote-ssh
    arrterian.nix-env-selector
    kamadorueda.alejandra
    timonwong.shellcheck
  ];
}
