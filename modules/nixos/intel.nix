{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };
  boot.kernelParams = ["i915.force_probe=46b3"];
}
