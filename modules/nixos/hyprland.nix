{pkgs, ...}: {
  # XDG Portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };
    configPackages = [pkgs.xdg-desktop-portal-gtk];
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    # configPackages = [ pkgs.xdg-desktop-portal-gtk ];
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  # Session Variables
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
  };
  # Cachix to not build Hyprland depedencies
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # Hyprlock
  security.pam.services.hyprlock = {};
}
