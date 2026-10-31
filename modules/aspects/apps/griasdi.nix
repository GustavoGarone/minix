{inputs, ...}: {
  den.aspects.apps.griasdi.nixos = {
    imports = [inputs.griasdi-nix.nixosModules.default];
    programs.griasdi.enable = true;
  };
}
