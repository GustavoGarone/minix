{
  den.aspects.optims = {
    nixos = {
      nix.settings.auto-optimise-store = true;
      nix.gc = {
        automatic = true;
        dates = "15d";
        options = "--delete-older-than 15d";
      };

      zramSwap = {
        enable = true;
        priority = 100;
        memoryPercent = 50;
      };

      services.thermald.enable = true;

      fileSystems."/".options = ["noatime"];
    };
  };
}
