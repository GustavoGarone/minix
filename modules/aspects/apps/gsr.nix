{inputs, ...}: {
  den.aspects.apps.gsr.nixos = {pkgs, ...}: {
    imports = [inputs.gsr-ui-nix.nixosModules.default];
    programs.gpu-screen-recorder = {
      package = inputs.gsr-ui-nix.packages.${pkgs.stdenv.hostPlatform.system}.gpu-screen-recorder;
      enable = true;
      ui.enable = true;
      # Work around upstream passing fetchSubmodules to builtins.fetchGit.
      ui.notificationPackage =
        inputs.gsr-ui-nix.packages.${pkgs.stdenv.hostPlatform.system}.gpu-screen-recorder-notification.overrideAttrs
        (_: {
          src = builtins.fetchGit {
            url = "https://repo.dec05eba.com/gpu-screen-recorder-notification";
            rev = "54bc6c8f139a5ff4025a4585d01c9e3f23894b72";
            submodules = true;
          };
        });
    };
  };
}
