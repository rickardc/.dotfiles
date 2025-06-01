{
  config,
  pkgs,
  ...
}: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    vscode-langservers-extracted

    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        bmewburn.vscode-intelephense-client
        codezombiech.gitignore
        davidanson.vscode-markdownlint
        ecmel.vscode-html-css
        esbenp.prettier-vscode
        firefox-devtools.vscode-firefox-debug
        foxundermoon.shell-format
        kamadorueda.alejandra
        mechatroner.rainbow-csv
        ms-azuretools.vscode-docker
        ms-python.black-formatter
        ms-python.debugpy
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.datawrangler
        ms-toolsai.jupyter
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        ms-vscode.cpptools
        ms-vscode.cpptools-extension-pack
        pollywoggames.pico8-ls
        redhat.vscode-xml
        redhat.vscode-yaml
        streetsidesoftware.code-spell-checker
        tamasfe.even-better-toml
        vscodevim.vim
      ];
    })
  ];
  programs.nix-ld.enable = true;
}
