{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    # Currently not working due to lag-behind of rofi-wayland
    plugins = [
      pkgs.rofi-emoji
      # pkgs.rofi-power-menu
      # pkgs.rofi-calc
    ];
    # theme = lib.mkForce "/home/minze/.local/share/rofi/themes/catppuccin-mocha.rasi";
  };
}
