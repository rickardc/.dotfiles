{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vscode-langservers-extracted

    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        arrterian.nix-env-selector
        bbenoist.nix
        bmewburn.vscode-intelephense-client
        davidanson.vscode-markdownlint
        dbaeumer.vscode-eslint
        enkia.tokyo-night
        kamadorueda.alejandra
        ms-python.python
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        ms-toolsai.jupyter
        ms-vscode.cpptools-extension-pack
        ms-vscode-remote.remote-ssh
        redhat.ansible
        redhat.vscode-yaml
        tamasfe.even-better-toml
        timonwong.shellcheck
        ex3ndr.llama-coder
      ];
    })
  ];
}
