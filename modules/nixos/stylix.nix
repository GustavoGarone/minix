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
  # Stylix theming
  stylix = {
    enable = true;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    base16Scheme = {
      name = "Everforest Light (Medium)";
      variant = "light";
      base00 = "#fdf6e3";
      base01 = "#f4f0d9";
      base02 = "#e6e2cc";
      base03 = "#939f91";
      base04 = "#829181";
      base05 = "#5c6a72";
      base06 = "#475258";
      base07 = "#2d353b";
      base08 = "#f85552";
      base09 = "#f57d26";
      base0A = "#dfa000";
      base0B = "#8da101";
      base0C = "#35a77c";
      base0D = "#3a94c5";
      base0E = "#df69ba";
      base0F = "#829181";
    };

    autoEnable = true;
    # image = ../../wallpapers/maecatwalk.png;
    # polarity = "dark";
    homeManagerIntegration.autoImport = false;
    homeManagerIntegration.followSystem = true;
  };
  environment.systemPackages = with pkgs; [
    extminvim
  ];
}
