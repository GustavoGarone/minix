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
        dolphin
        tidal-hifi
        proton-pass
      ];
    };
  };

  den.hosts.x86_64-linux.laptop.users.${user} = cfg;
  den.hosts.x86_64-linux.desktop.users.${user} = cfg;
}
