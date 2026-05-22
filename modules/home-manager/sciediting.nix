{
  pkgs,
  outputs,
  ...
}: {
  nixpkgs.overlays = [outputs.overlays.unstable-packages];
  home.packages = with pkgs; [
    marksman
    librsvg # Convert svgs
    unstable.zotero
    tex-fmt # Latex formatter
    poppler-utils # For converting pdf to svg (pgfxplots)
  ];
}
