{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    zed.url = "github:zed-industries/zed";
    stylix = {
      url = "github:danth/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minvim.url = "github:GustavoGarone/minvim";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    minvim,
    zen-browser,
    stylix,
    nixcord,
    auto-cpufreq,
    zed,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
          neovim = minvim.packages.${system}.default;
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
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {inherit inputs system;};
          home-manager.useUserPackages = true;
          home-manager.users.minze = import ./desktop/home.nix;
          home-manager.backupFileExtension = "bkphm";
          home-manager.sharedModules = [
            nixcord.homeModules.nixcord
            stylix.homeModules.stylix
            zen-browser.homeModules.beta
          ];
        }
      ];
    };
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs system;};
      modules = [
        ./laptop/configuration.nix
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        auto-cpufreq.nixosModules.default
        {
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.useUserPackages = true;
          home-manager.users.minze = import ./laptop/home.nix;
          home-manager.backupFileExtension = "bkphm";
          home-manager.sharedModules = [
            nixcord.homeModules.nixcord
            stylix.homeModules.stylix
            zen-browser.homeModules.beta
          ];
        }
      ];
    };
  };
}
