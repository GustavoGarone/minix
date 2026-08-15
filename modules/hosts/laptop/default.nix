{den, ...}: {
  den.hosts.x86_64-linux.laptop = {
    isLaptop = true;
    gitSigningKey = "8EC0399DAED73E80";
    displays = {
      eDP-1 = {
        primary = true;
        refresh = 120.213;
        width = 1920;
        height = 1080;
        x = 1920;
      };
      HDMI-A-1 = {
        refresh = 60.000;
        width = 1920;
        height = 1080;
      };
    };
  };

  den.aspects.laptop = {
    includes = with den.aspects; [
      stylix
      optims
      utils
      xdg
      gaming

      desktop-environments.niri.with-waybar

      development.git
      development.direnv
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

      services.auto-cpufreq
    ];

    nixos = {
      system.stateVersion = "23.11"; # Did you read the comment?

      networking.networkmanager.enable = true;

      hardware.bluetooth = {
        enable = true;
        settings.General.Experimental = true;
      };

      services.thermald.enable = true;
    };
    homeManager = {
      home.stateVersion = "23.11"; # Please read the comment before changing.
    };
  };
}
