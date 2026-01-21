{pkgs, ...}: {
  services.copyq = {
    enable = true;
    forceXWayland = false;
  };
}
