{
  den.aspects.desktop.nixos = {
    config,
    lib,
    modulesPath,
    pkgs,
    ...
  }: {
    # Nvidia 1050 ti desktop
    services.xserver.videoDrivers = ["nvidia"];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
      ];
    };
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";
    };
    hardware.nvidia = {
      open = false;
      modesetting.enable = true;
      nvidiaSettings = true;
      # I'm old!
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      powerManagement.enable = true;
    };
    boot.loader = {
      grub.enable = true;
      grub.device = "/dev/sda";
    };

    # From hardware-configuration.nix =========================================
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = [];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/9f506ce6-ba31-47b9-8dc9-ee1a42b8f6df";
      fsType = "ext4";
    };

    fileSystems."/mnt/hdnixos" = {
      device = "/dev/disk/by-partuuid/5f9b4ab9-6c2e-4c21-bb7e-34ba05600176";
      fsType = "ext4";
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
