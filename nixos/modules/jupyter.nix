{pkgs, ...}: {
  services.jupyter = {
    enable = true;
    user = "chris";
    port = 8888;
    notebookDir = "/home/chris/notebooks"; # ~ by default
    password = "sha1:1b961dc713fb:88483270a63e57d18d43cf337e629539de1436ba"; # password is 'test'
    notebookConfig = ''
      c.Application.log_level = 'DEBUG'
      c.Session.debug = True
      c.KernelManager.debug_kernel = True
    '';

    kernels = {
      # Python3 kernel
      python3 = let
        env = (
          pkgs.python3.withPackages (
            pythonPackages:
              with pythonPackages; [
                ipykernel
                jupyterlab
                pandas
                polars
                numpy
                matplotlib
                seaborn
                plotly
                altair
                scipy
                scikitlearn
                xgboost
                lightgbm
                statsmodels
                sympy
                ipywidgets
                requests
                tqdm
                openpyxl
                pyarrow
                black
              ]
          )
        );
      in {
        #displayName = "Python ${env.pythonVersion}";
        displayName = "Python ${pkgs.lib.getVersion env}";
        argv = [
          "${env.interpreter}"
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
        ];
        language = "python";
        #  logo32 = builtins.toPath "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
        #  logo64 = builtins.toPath "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
      };
    };
  };
}
