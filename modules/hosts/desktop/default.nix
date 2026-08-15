{den, ...}: {
  den.hosts.x86_64-linux.desktop = {
    gitSigningKey = "A689A86A2F82A235";
    displays = {
      HDMI-A-1 = {
        primary = true;
        refresh = 74.986;
        width = 1920;
        height = 1080;
      };
    };
  };

  den.aspects.desktop = {
    includes = with den.aspects; [
      stylix
      optims
      utils
      xdg
      gaming

      desktop-environments.niri.with-waybar

      development.git
      development.direnv
      development.postgresql
      editors.helix
      terminals.kitty
      shells.fish

      apps.browsers.zen-browser
      apps.discord
      apps.obsidian
      apps.fastfetch
      apps.mpv
      apps.btop
      apps.zellij
      apps.yazi
      apps.proton-vpn
      apps.gsr
    ];

    nixos = {
      system.stateVersion = "25.11"; # Did you read the comment?
    };
    homeManager = {
      home.stateVersion = "25.11"; # Please read the comment before changing.
    };
  };
}
