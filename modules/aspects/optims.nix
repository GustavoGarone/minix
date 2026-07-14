{
  den.aspects.optims = let
    nix = {
      gc = {
        automatic = true;
        dates = "15d";
        options = "--delete-older-than 15d";
      };
      settings.auto-optimise-store = true;
    };
  in {
    nixos = {
      nix.gc = {inherit nix;};

      zramSwap = {
        enable = true;
        priority = 100;
        memoryPercent = 50;
      };

      services.thermald.enable = true;

      fileSystems."/".options = ["noatime"];
    };
    home-manager = {
      nix = {inherit nix;};
    };
  };
}
