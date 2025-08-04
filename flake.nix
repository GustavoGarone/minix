{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minvim.url = "github:GustavoGarone/minvim";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixcord.url = "github:kaylorben/nixcord";
    hyprland.url = "github:hyprwm/Hyprland";
    minshell.url = "github:GustavoGarone/minshell";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    minvim,
    zen-browser,
    stylix,
    nixcord,
    hyprland,
    minshell,
    auto-cpufreq,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
          neovim = minvim.packages.${system}.default;
        })
        (final: prev: {
          quickshell = minshell.packages.${system}.default;
        })
      ];
    };
  in {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./desktop/configuration.nix
        stylix.nixosModules.stylix
        hyprland.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {inherit inputs;};
          # home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.minze = import ./desktop/home.nix;
          home-manager.sharedModules = [
            nixcord.homeModules.nixcord
            stylix.homeModules.stylix
            zen-browser.homeModules.beta
            # {
            #   wayland.windowManager.hyprland = {
            #     enable = true;
            #     package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            #     portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
            #     # package = null;
            #     # portalPackage = null;
            #   };
            # }
          ];
        }
      ];
    };
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./laptop/configuration.nix
        stylix.nixosModules.stylix
        hyprland.nixosModules.default
        home-manager.nixosModules.home-manager
        auto-cpufreq.nixosModules.default
        {
          home-manager.extraSpecialArgs = {inherit inputs;};
          # home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.minze = import ./laptop/home.nix;
          home-manager.sharedModules = [
            nixcord.homeModules.nixcord
            stylix.homeModules.stylix
            zen-browser.homeModules.beta
            # {
            #   wayland.windowManager.hyprland = {
            #     enable = true;
            #     package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            #     portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
            #     # package = null;
            #     # portalPackage = null;
            #   };
            # }
          ];
        }
      ];
    };
  };
}
