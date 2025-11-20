{pkgs, ...}: {
  # Stylix theming
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    autoEnable = true;
    # image = ~/wallpapers/nitwcitynight.jpg;
    # polarity = "dark";
    homeManagerIntegration.autoImport = false;
    homeManagerIntegration.followSystem = true;
    targets = {
      zen-browser = {
        profileNames = ["garonegustavo@gmail.com"];
      };
    };
  };
}
