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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
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
