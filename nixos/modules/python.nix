{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (python3.withPackages
      (
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
      ))
  ];
}
