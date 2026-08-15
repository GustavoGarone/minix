{
  den.aspects.apps.waybar.modules.desktop = {
    homeManager = {
      programs.waybar.settings.main = {
        modules-right = [
          "mpris"
          "tray"
          "privacy"
          "network"
          "pulseaudio"
        ];
      };
    };
  };
}
