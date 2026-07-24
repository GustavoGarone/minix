{
  den.aspects.laptop.nixos = {
    config,
    lib,
    modulesPath,
    pkgs,
    ...
  }: {
    # Intel laptop
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
      ];
    };
    boot.kernelParams = ["i915.force_probe=46b3"];
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
    hardware.enableRedistributableFirmware = true;
    services.xserver.videoDrivers = ["modesetting"];

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # From hardware-configuration.nix =========================================
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/4122d0d0-a26f-4bbc-9c41-f6798014c4ac";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/C0ED-4034";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
