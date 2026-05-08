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
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    # while https://github.com/tinted-theming/schemes/pull/98 doesn't get merged in nixpkgs
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
    polarity = "light";
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
      ghostty = {
        opacity.override.terminal = 0.85;
        fonts.override.monospace.name = "VictorMono NF";
      };
      gtk.extraCss = "*{border-radius:0px;}";
    };
  };

  # Minvim with stylix
  home.packages = with pkgs; [
    # extminvim
  ];
}
