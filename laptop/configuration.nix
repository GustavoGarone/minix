{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  nixvim-package = inputs.minvim.packages.${system}.default;
  extminvim = nixvim-package.extend config.lib.stylix.nixvim.config;
in {
  nixpkgs.config.allowUnfree = true;
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../modules/nixos/intel.nix
    # Probably not a good idea to use both!
    ../modules/nixos/auto-cpufreq.nix
    ../modules/nixos/tlp.nix
    ../modules/nixos/hyprland.nix
    ../modules/nixos/fish.nix
    ../modules/nixos/optimize.nix
    ../modules/nixos/ssh.nix
    ../modules/nixos/fonts.nix
    ../modules/nixos/network.nix
  ];

  boot = {
    kernelParams = ["i915.force_probe=46b3"];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.minze.uid}";
  };

  programs.dconf.enable = true;
  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  services.upower = {
    enable = true;
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.minze = {
    isNormalUser = true;
    description = "minze";
    extraGroups = ["networkmanager" "wheel" "docker" "libvirtd"];
    packages = with pkgs; [];
  };

  # Sessions variables
  environment.sessionVariables = {
    # LD_LIBRARY_PATH = "${pkgs.gcc.cc.lib}/lib:${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH";
    # LD_LIBRARY_PATH = "${pkgs.gfortran.cc.lib}/lib";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    EDITOR = "nvim";
    GTK_USE_PORTAL = "1";
  };

  environment.systemPackages = with pkgs; [
    wget
    # (
    #   waybar.overrideAttrs (oldAttrs: {
    #     mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    #   })
    # )

    extminvim

    # Git
    nix-prefetch-github
    git
    gh

    glib
    gcc
    gfortran
    gfortran.cc.lib
    libgccjit
    gnumake
    cmake
    extra-cmake-modules

    #xdg
    # xdg-utils
    # dconf

    qt6.qtwayland
    # libsForQt5.qt5.qtwayland
    # hunspell
    # hunspellDicts.pt_BR
  ];

  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
  };

  # Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Stylix theming
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    autoEnable = true;
    # image = ~/wallpapers/nitwcitynight.jpg;
    # polarity = "dark";
    homeManagerIntegration.autoImport = false;
    homeManagerIntegration.followSystem = true;
  };

  # ZSH Shell
  # programs.zsh.enable = true;
  # users.defaultUserShell = pkgs.zsh;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
  };

  # Polkit privilege manager
  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  services.fwupd.enable = true;

  # Security
  services.fail2ban.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [22];
  networking.firewall.allowedUDPPorts = [22 30502];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
