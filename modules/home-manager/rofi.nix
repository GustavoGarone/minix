{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    # Currently not working due to lag-behind of rofi-wayland
    plugins = [
      pkgs.rofi-emoji-wayland
      # pkgs.rofi-power-menu
      # pkgs.rofi-calc
    ];
    # theme = lib.mkForce "/home/minze/.local/share/rofi/themes/catppuccin-mocha.rasi";
  };
}
