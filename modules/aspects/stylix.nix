{inputs, ...}: {
  den.aspects.stylix = {
    nixos = {pkgs, ...}: let
      scheme = name: "${pkgs.base16-schemes}/share/themes/${name}.yaml";
    in {
      imports = [inputs.stylix.nixosModules.stylix];

      stylix = {
        enable = true;
        base16Scheme = scheme "chalk";
        polarity = "dark";

        icons = {
          enable = true;
          package = pkgs.adwaita-icon-theme;
          dark = "Adwaita";
          light = "Adwaita";
        };

        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 14;
        };

        fonts = {
          sizes.popups = 10;
          sansSerif = {
            package = pkgs.texlivePackages.nunito;
            name = "Nunito";
          };
          monospace = {
            package = pkgs.nerd-fonts.victor-mono;
            name = "VictorMono NF";
          };
        };
      };
    };

    homeManager = {pkgs, ...}: {
      stylix = {
        enable = true;
        fonts.sizes.desktop = 10;
        targets = {
          waybar = {
            font = "sansSerif";
            fonts.override.sansSerif.name = "Nunito, JetBrainsMono Nerd Font Propo";
            addCss = false;
          };
          cava.rainbow.enable = true;
          kitty.opacity.override.terminal = 0.95;
          wofi.fonts.override.monospace.name = "Nunito";
          obsidian.fonts.override.sizes.applications = 14;
          helix.opacity.override.terminal = 0;
          gtk.extraCss = "*{border-radius:0px;}";
        };
      };
    };
  };
}
