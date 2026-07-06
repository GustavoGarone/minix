{den, ...}: {
  den.default = {
    includes = [
      # including the `host-aspects` batteries will
      # forward any `homeManager` key from the host
      # to the user.
      # https://den.denful.dev/reference/batteries/#denbatterieshost-aspects
      den.batteries.host-aspects
    ];

    nixos = {
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      nixpkgs.config.allowUnfree = true;

      networking.hostName = "den";

      time.timeZone = "America/Sao_Paulo";

      programs.gnupg.agent.enable = true;

      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "pt_BR.UTF-8";
        LC_IDENTIFICATION = "pt_BR.UTF-8";
        LC_MEASUREMENT = "pt_BR.UTF-8";
        LC_MONETARY = "pt_BR.UTF-8";
        LC_NAME = "pt_BR.UTF-8";
        LC_NUMERIC = "pt_BR.UTF-8";
        LC_PAPER = "pt_BR.UTF-8";
        LC_TELEPHONE = "pt_BR.UTF-8";
        LC_TIME = "pt_BR.UTF-8";
      };

      nix.settings.experimental-features = ["nix-command" "flakes"];
    };
  };
}
