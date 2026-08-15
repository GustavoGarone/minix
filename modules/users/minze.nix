{
  inputs,
  den,
  ...
}: let
  user = "minze";
  cfg = {
    classes = [
      "homeManager"
      "user"
      "wheel"
      "networkmanager"
      "gamemode"
    ];
  };
in {
  den.aspects.${user} = {
    includes = [
      den.batteries.primary-user
      (den.batteries.user-shell "fish")
      (den.batteries.unfree [
        "castlabs-electron" # for tidal-hifi
      ])
      den.aspects.apps.core.gui
    ];

    homeManager = {pkgs, ...}: let
      unstable = import inputs.nixpkgs-unstable {
        system = pkgs.stdenv.hostPlatform.system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-38.8.4"
          ];
        };
      };
    in {
      home.packages = with pkgs; [
        tidal-hifi
        proton-pass
        telegram-desktop
        julia
        libreoffice
        unstable.codex
        qbittorrent
        unstable.stoat-desktop
      ];
      home.sessionVariables = {
        EDITOR = "hx";
      };
    };
  };

  den.hosts.x86_64-linux.laptop.users.${user} = cfg;
  den.hosts.x86_64-linux.desktop.users.${user} = cfg;
}
