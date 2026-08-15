{
  den.aspects.optims = let
    nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 15d";
      };
      settings.auto-optimise-store = true;
    };
  in {
    nixos = {
      inherit nix;
      zramSwap = {
        enable = true;
        priority = 100;
        memoryPercent = 50;
      };
      boot.kernel.sysctl."vm.swappiness" = 100;

      services.fstrim = {
        enable = true;
        interval = "weekly";
      };

      fileSystems."/".options = ["noatime"];
    };
    home-manager = {
      inherit nix;
    };
  };
}
