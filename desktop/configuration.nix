{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../modules/nixos/nvidia.nix
    ../modules/nixos/hyprland.nix
    ../modules/nixos/fish.nix
    ../modules/nixos/optimize.nix
    ../modules/nixos/ssh.nix
    ../modules/nixos/steam.nix
    ../modules/nixos/fonts.nix
    ../modules/nixos/network.nix
    ../modules/nixos/protonvpn.nix
    ../modules/nixos/stylix.nix
    ../modules/nixos/kernel.nix
  ];
  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    #    efi.canTouchEfiVariables = true;
    grub.enable = true;
    grub.device = "/dev/sda";
    grub.useOSProber = true;
  };

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.minze.uid}";
  };

  programs.dconf.enable = true;
  powerManagement.cpuFreqGovernor = "performance";

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

  programs.nix-ld.enable = true;

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.minze = {
    isNormalUser = true;
    description = "minze";
    extraGroups = ["networkmanager" "wheel" "docker" "libvirtd" "gamemode"];
    packages = with pkgs; [];
  };

  nix.settings.trusted-users = ["minze"];

  # Sessions variables
  environment.sessionVariables = {
    # LD_LIBRARY_PATH = "${pkgs.gcc.cc.lib}/lib:${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH";
    NIXOS_OZONE_WL = "1";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    EDITOR = "hx";
  };

  environment.systemPackages = with pkgs; [
    wget

    neovim
    nix-prefetch-github
    git
    gh

    glib
    gcc
    gnumake
    cmake
    extra-cmake-modules

    qt6.qtwayland
  ];

  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  # Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # services.logmein-hamachi.enable = true;

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
  system.stateVersion = "25.11"; # Did you read the comment?
}
