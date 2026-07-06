{
  den.aspects.apps.waybar.modules.laptop = {
    homeManager = {
      programs.waybar.settings.main = {
        modules-right = [
          "mpris"
          "tray"
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
