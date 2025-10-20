{pkgs, ...}: {
  programs.caelestia = {
    enable = true;
    systemd = {
      target = "graphical-session.target";
      environment = [];
    };
    settings = {
      bar.status = {
        showBattery = true;
      };
      paths.wallpaperDir = "~/Pictures/Wallpapers/";
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme.enableGtk = false;
      };
    };
  };
}
