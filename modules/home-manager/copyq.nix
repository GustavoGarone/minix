{pkgs, ...}: {
  services.copyq = {
    enable = true;
    forceXWayland = false;
  };
  home.packages = with pkgs; [
    wl-clipboard
  ];
}
