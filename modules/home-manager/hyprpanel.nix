{pkgs, ...}: {
  programs.hyprpanel = {
    enable = true;
    settings = {
      layout = {
        bar.layouts = {
          "0" = {
            left = ["dashboad" "workspaces"];
            middle = ["media"];
            right = ["volume" "systray" "notifications"];
          };
        };
      };
      theme.bar.transparent = true;
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard.stats.enable_gpu = true;
      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };
  wayland.windowManager.hyprland = {
    settings.exec-once = ["hyprpanel"];
  };
}
