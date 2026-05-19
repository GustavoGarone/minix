{
  "Mod+Shift+Slash".action.show-hotkey-overlay = [];
  "Mod+Q" = {
    hotkey-overlay.title = "Open ghostty";
    action.spawn = ["env" "GTK_IM_MODULE=simple" "ghostty"];
  };
  "Mod+A" = {
    hotkey-overlay.title = "Open launcher";
    action.spawn = ["wofi" "--show" "drun" "--show-icons"];
  };
  "Mod+E" = {
    hotkey-overlay.title = "Open file explorer";
    action.spawn = "dolphin";
  };
  "Mod+O" = {
    repeat = false;
    action.toggle-overview = [];
  };
  "Mod+C" = {
    repeat = false;
    action.close-window = [];
  };
  "XF86AudioRaiseVolume" = {
    action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "2%+"];
  };
  "XF86AudioLowerVolume" = {
    action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "2%-"];
  };
  "Mod+P".action.spawn = ["hyprpicker" "-a"];
  "Mod+Left".action.focus-column-left = [];
  "Mod+Down".action.focus-window-or-workspace-down = [];
  "Mod+Up".action.focus-window-or-workspace-up = [];
  "Mod+Right".action.focus-column-right = [];
  "Mod+H".action.focus-column-left = [];
  "Mod+J".action.focus-window-or-workspace-down = [];
  "Mod+K".action.focus-window-or-workspace-up = [];
  "Mod+L".action.focus-column-right = [];
  "Mod+Shift+Left".action.move-column-left = [];
  "Mod+Shift+Down".action.move-window-down-or-to-workspace-down = [];
  "Mod+Shift+Up".action.move-window-up-or-to-workspace-up = [];
  "Mod+Shift+Right".action.move-column-right = [];
  "Mod+Shift+H".action.move-column-left = [];
  "Mod+Shift+J".action.move-window-down-or-to-workspace-down = [];
  "Mod+Shift+K".action.move-window-up-or-to-workspace-up = [];
  "Mod+Shift+L".action.move-column-right = [];
  "Mod+Home".action.focus-column-first = [];
  "Mod+End".action.focus-column-last = [];
  "Mod+Shift+Home".action.move-column-to-first = [];
  "Mod+Shift+End".action.move-column-to-last = [];
  "Mod+D".action.focus-workspace-down = [];
  "Mod+U".action.focus-workspace-up = [];
  "Mod+Shift+D".action.move-column-to-workspace-down = [];
  "Mod+Shift+U".action.move-column-to-workspace-up = [];
  "Mod+WheelScrollDown" = {
    cooldown-ms = 100;
    action.focus-workspace-down = [];
  };
  "Mod+WheelScrollUp" = {
    cooldown-ms = 100;
    action.focus-workspace-up = [];
  };
  "Mod+Shift+WheelScrollDown".action.focus-column-right = [];
  "Mod+Shift+WheelScrollUp".action.focus-column-left = [];
  "XF86MonBrightnessUp" = {
    allow-when-locked = true;
    action.spawn = ["brightnessctl" "--class=backlight" "set" "+10%"];
  };
  "XF86MonBrightnessDown" = {
    allow-when-locked = true;
    action.spawn = ["brightnessctl" "--class=backlight" "set" "-10%"];
  };
  "Mod+BracketLeft".action.consume-or-expel-window-left = [];
  "Mod+BracketRight".action.consume-or-expel-window-right = [];
  "Mod+Comma".action.consume-window-into-column = [];
  "Mod+Period".action.expel-window-from-column = [];
  "Mod+Shift+R".action.switch-preset-column-width = [];
  "F11".action.fullscreen-window = [];
  "Mod+F".action.maximize-column = [];
  "Mod+Shift+F".action.expand-column-to-available-width = [];
  "Mod+Ctrl+X".action.center-column = [];
  "Mod+Shift+X".action.center-visible-columns = [];
  "Mod+Minus".action.set-column-width = ["-10%"];
  "Mod+Equal".action.set-column-width = ["+10%"];
  "Mod+Shift+Minus".action.set-window-height = ["-10%"];
  "Mod+Shift+Equal".action.set-window-height = ["+10%"];
  "Mod+T".action.toggle-window-floating = [];
  "Mod+Shift+T".action.switch-focus-between-floating-and-tiling = [];
  "Mod+W".action.toggle-column-tabbed-display = [];
  "Print".action.screenshot = [];
  # "Mod+S".action.screenshot.write-to-disk = false;
  "Mod+S".action.screenshot = [];
  "Ctrl+Print".action.screenshot-screen = [];
  "Mod+Shift+S".action.screenshot-screen = [];
  "Mod+Alt+S".action.screenshot-window = [];
  "Mod+Escape" = {
    allow-inhibiting = false;
    action.toggle-keyboard-shortcuts-inhibit = [];
  };
  "Mod+M".action.quit.skip-confirmation = false;
  "Mod+Shift+M".action.quit.skip-confirmation = true;
  "Mod+1".action.focus-workspace = 1;
  "Mod+2".action.focus-workspace = 2;
  "Mod+3".action.focus-workspace = 3;
  "Mod+4".action.focus-workspace = 4;
  "Mod+5".action.focus-workspace = 5;
  "Mod+6".action.focus-workspace = 6;
  "Mod+7".action.focus-workspace = 7;
  "Mod+8".action.focus-workspace = 8;
  "Mod+9".action.focus-workspace = 9;
  "Mod+Shift+1".action.move-column-to-workspace = 1;
  "Mod+Shift+2".action.move-column-to-workspace = 2;
  "Mod+Shift+3".action.move-column-to-workspace = 3;
  "Mod+Shift+4".action.move-column-to-workspace = 4;
  "Mod+Shift+5".action.move-column-to-workspace = 5;
  "Mod+Shift+6".action.move-column-to-workspace = 6;
  "Mod+Shift+7".action.move-column-to-workspace = 7;
  "Mod+Shift+8".action.move-column-to-workspace = 8;
  "Mod+Shift+9".action.move-column-to-workspace = 9;
}
