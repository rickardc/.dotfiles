{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (ps:
      with ps; [
        jupyter
        ipython
        pandas
        numpy
        matplotlib
        seaborn
      ]))
  ];

  shellHook = "jupyter notebook --no-browser";
}
