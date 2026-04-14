{pkgs, ...}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  # nixvim-package = inputs.minvim.packages.${system}.default;
  # extminvim =
  #   nixvim-package.extend
  #   config.stylix.targets.nixvim.exportedModule;
in {
  stylix = {
    enable = true;
    # image = ../../wallpapers/maecatwalk.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/harmonic16-light.yaml";
    # polarity = "dark";
    opacity.terminal = 0.8;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 14;
    };
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
    fonts = {
      sizes.desktop = 10;
      monospace = {
        package = pkgs.nerd-fonts.victor-mono;
        name = "VictorMono NF";
      };
    };
    targets = {
      hyprland = {
        enable = true;
        hyprpaper.enable = false;
      };
      zen-browser = {
        enable = false;
      };
      ghostty = {
        opacity.override.terminal = 0.85;
        fonts.override.monospace.name = "VictorMono NF";
      };
    };
  };

  # Minvim with stylix
  home.packages = with pkgs; [
    # extminvim
  ];
}
