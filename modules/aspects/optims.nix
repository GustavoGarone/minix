{
  den.aspects.optims = let
    garbage-collection = {
      automatic = true;
      dates = "15d";
      options = "--delete-older-than 15d";
    };
  in {
    nixos = {
      nix.settings.auto-optimise-store = true;
      nix.gc = {inherit garbage-collection;};

      zramSwap = {
        enable = true;
        priority = 100;
        memoryPercent = 50;
      };

      services.thermald.enable = true;

      fileSystems."/".options = ["noatime"];
    };
    home-manager = {
      nix.gc = {inherit garbage-collection;};
    };
  };
}
