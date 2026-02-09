{pkgs, ...}: {
  home.Packages = with pkgs; [
    element-desktop
    fractal
  ];
}
