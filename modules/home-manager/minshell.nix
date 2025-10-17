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
  };
}
