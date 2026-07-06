{
  den.aspects.apps.waybar.modules.laptop = {
    homeManager = {
      programs.waybar.settings.main = {
        modules-right = [
          "tray"
          "mpris"
          "privacy"
          "network"
          "bluetooth"
          "pulseaudio"
          "backlight/slider"
          "battery"
        ];
      };
    };
  };
}
