{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (ps:
      with ps; [
        jupyter
        ipython
        ipykernel
        pandas
        numpy
        matplotlib
        seaborn
        black
        scipy
        pytest
      ]))
  ];

  shellHook = ''
    if ! jupyter kernelspec list | grep -q my-nix-env; then
      echo "Registering Jupyter kernel for VS Code..."
      python -m ipykernel install --user --name my-nix-env --display-name "Python (Nix)"
    fi
  '';
}
