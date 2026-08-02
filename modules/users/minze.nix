{
  __findFile,
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
      <den/primary-user>
      (<den/user-shell> "fish")
      (<den/unfree> [
        "castlabs-electron" # for tidal-hifi
      ])
      den.aspects.apps.core.gui
    ];

    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        tidal-hifi
        proton-pass
        julia
        libreoffice
        codex
        qbittorrent
      ];
      home.sessionVariables = {
        EDITOR = "hx";
      };
    };
  };

  den.hosts.x86_64-linux.laptop.users.${user} = cfg;
  den.hosts.x86_64-linux.desktop.users.${user} = cfg;
}
