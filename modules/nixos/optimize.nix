{
  # Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 30d";
  };

  # Zram swap
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 50;
  };

  # Enable Direnv
  programs.direnv.enable = true;

  # thermald overheating protection
  services.thermald.enable = true;

  # For FSH problems
  programs.nix-ld.enable = true;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Optimize storage
  nix.settings.auto-optimise-store = true;

  # Enable memory killing.
  # services.earlyoom = {
  #   enable = true;
  # };

  # Disables access-time writing
  fileSystems."/".options = ["noatime"];
}
