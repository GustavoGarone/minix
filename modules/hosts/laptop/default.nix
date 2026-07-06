{den, ...}: {
  den.hosts.x86_64-linux.laptop = {
    isLaptop = true;
    displays = {
      eDP-1 = {
        primary = true;
        refresh = 120.213;
        width = 1920;
        height = 1080;
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
      nix
      xdg

      desktop-environments.niri

      development.git
      development.direnv
      terminals.kitty
      shells.fish

      apps.browsers.zen-browser
      apps.discord
      apps.obsidian
      apps.fastfetch
      apps.mpv
      apps.btop
      apps.yazi

      services.auto-cpufreq
    ];

    nixos = {
      host,
      pkgs,
      ...
    }: {
      services.xserver.xkb.layout = host.keyboardLayout;
      console.useXkbConfig = true;

      networking.networkmanager.enable = true;

      hardware.bluetooth = {
        enable = true;
        settings.General.Experimental = true;
      };
    };
  };
}
