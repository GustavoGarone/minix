{inputs, ...}: {
  den.aspects.apps.gsr.nixos = {pkgs, ...}: {
    imports = [inputs.gsr-ui-nix.nixosModules.default];
    programs.gpu-screen-recorder = {
      package = inputs.gsr-ui-nix.packages.${pkgs.stdenv.hostPlatform.system}.gpu-screen-recorder;
      enable = true;
      ui.enable = true;
    };
  };
}
