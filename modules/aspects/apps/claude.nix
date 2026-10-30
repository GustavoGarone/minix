{inputs, ...}: {
  den.aspects.apps.claude-code.homeManager = {pkgs, ...}: {
    home.packages = [
      inputs.claude-code-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  den.aspects.apps.claude-science.homeManager = {pkgs, ...}: {
    home.packages = [
      inputs.claude-science-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  den.aspects.apps.claude-desktop.nixos = {pkgs, ...}: {
    imports = [inputs.claude-desktop-nix-flake.nixosModules.default];
    programs.claude-desktop = {
      enable = true;
      package = inputs.claude-desktop-nix-flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
}
