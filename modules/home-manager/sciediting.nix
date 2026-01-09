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
    zotero
    (texlive.withPackages
      (ps: [ps.scheme-small ps.luatex]))
    tex-fmt # Latex formatter in rust
    poppler-utils # For converting pdf to svg (pgfxplots)
  ];
}
