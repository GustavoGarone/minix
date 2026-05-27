{pkgs, ...}: {
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
}
