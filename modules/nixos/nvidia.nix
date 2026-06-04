{
  config,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl
    ];
  };
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    powerManagement.enable = true;
  };
  environment.sessionVariables = {
    NVD_BACKEND = "direct"; # GPU acceleration ?
    GBM_BACKEND = "nvidia-drm"; # Required for GPU acceleration
    LIBVA_DRIVER_NAME = "nvidia";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    VDPAU_DRIVER = "va_gl";
  };
}
