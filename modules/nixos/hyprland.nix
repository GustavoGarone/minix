{pkgs, ...}: {
  import = ./xdg-portals.nix:
  xdg.portal = {
    config = {
      hyprland.default = ["hyprland" "gtk"];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
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
  environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
  # Cachix to not build Hyprland depedencies
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  # Hyprland
  programs.hyprland = {
    enable = true; # Already handles the xdg-desktop-portal-hyprland
    xwayland.enable = true;
  };
  # Hyprlock
  security.pam.services.hyprlock = {};
}
