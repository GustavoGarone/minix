{
  description = "Minix config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    zed.url = "github:zed-industries/zed";
    stylix = {
      url = "github:danth/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
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
    nixpkgs-unstable,
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
    inherit (self) outputs;
  in {
    overlays = {
      neovim = final: prev: {
        neovim = minvim.packages.${system}.default;
      };
      unstable-packages = final: _prev: {
        unstable = import nixpkgs-unstable {
          system = final.system;
          config.allowUnfree = true;
        };
      };
    };

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs;
      };
      modules = [
        ./desktop/configuration.nix
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {inherit inputs outputs;};
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
      specialArgs = {inherit inputs outputs;};
      modules = [
        ./laptop/configuration.nix
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        auto-cpufreq.nixosModules.default
        {
          home-manager.extraSpecialArgs = {inherit inputs outputs;};
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
