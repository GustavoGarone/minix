{pkgs, ...}: {
  home.packages = with pkgs; [
    marksman
    librsvg # Convert svgs
    zotero
    tex-fmt # Latex formatter in rust
    poppler-utils # For converting pdf to svg (pgfxplots)
  ];
}
