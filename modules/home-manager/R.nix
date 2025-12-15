{pkgs, ...}: {
  home.packages = with pkgs; [
    R
    rPackages.languageserver
    rPackages.air
    rPackages.ggplot2
    air-formatter
  ];
}
