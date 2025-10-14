{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  nixvim-package = inputs.minvim.packages.${system}.default;
  extminvim =
    nixvim-package.extend
    config.stylix.targets.nixvim.exportedModule;
in {
  stylix = {
    enable = true;
    # image = ~/wallpapers/nitwcitynight.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    # polarity = "dark";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
    targets.hyprland = {
      enable = true;
      hyprpaper.enable = false;
    };
  };

  # Minvim with stylix
  home.packages = with pkgs; [
    extminvim
  ];
}
