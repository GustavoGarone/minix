{pkgs, ...}: {
  home.packages = with pkgs; [
    rPackages.languageserver
    rPackages.knitr
    rPackages.rmarkdown
    rPackages.quarto
    rPackages.air
    marksman
    air-formatter
    quarto
    texliveFull
    tex-fmt # Latex formatter in rust
    poppler-utils # For converting pdf to svg (pgfxplots)
  ];
}
