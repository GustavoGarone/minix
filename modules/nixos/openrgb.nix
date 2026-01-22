{pkgs, ...}:
{
  services.hardware.openrgb = {
    enable = true;
  }
  home.packages = with pkgs; [
    openrgb
  ]
}
