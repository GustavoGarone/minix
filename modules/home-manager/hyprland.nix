{
  lib,
  pkgs,
  ...
}: {
  # Home module hyprland config
  wayland.windowManager.hyprland = {
    # Tell NixOS to use system packages instead of home manager packes for portal
    # Compatibility
    # package = null;
    # portalPackage = null;
    enable = true;
    # catppuccin.enable = true;
    settings = {
      input.kb_layout = "br";
      input.touchpad.natural_scroll = true;

      general = {
        gaps_in = 1;
        gaps_out = 1;
        border_size = 1;
        layout = "dwindle";
        no_border_on_floating = "yes";

        # "col.active_border" = "rgb(579C79)";
        # "col.inactive_border" = "rgb(362419)";
      };

      env = [
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,16"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];

      decoration = {
        rounding = 2;
        blur.enabled = "true";
        # drop_shadow = "false";
      };
      animations.enabled = "yes";

      windowrulev2 = "opacity 1 0.75, class:Zed|codium|tidal-hifi|kitty";

      monitor = [
        "eDP-1, 1920x1080@120, -1920x0, 1.5"
        # "HDMI-A-1, 1920x1080@60, 0x0, 1"
        # ", preferred, auto-left, 1"
      ];

      exec-once = [
        "waybar"
        "hyprctl setcursor Bibata-Modern-Classic 16"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
      "$mod" = "SUPER";
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind =
        [
          "$mod, a, exec, rofi -show drun -show-icons"
          "$mod, x, exec, rofi -show power-menu -modi power-menu:rofi-power-menu"
          "$mod, i, exec, rofi -show emoji -modi emoji"
          "$mod SHIFT, M, exec, pkill Hyprland"
          "$mod SHIFT, l, exec, hyprlock"
          "$mod, s, exec, grimblast copy area --freeze"
          "$mod SHIFT, s, exec, grimblast save area --freeze"
          "$mod, q, exec, kitty"
          "$mod, e, exec, dolphin"
          "$mod, e, exec, kitty yazi"
          "$CTRL SHIFT, Escape, exec, kitty btop"

          "$mod, p, pseudo"
          "$mod, j, togglesplit"
          "$mod, c, killactive"
          "$mod, r, togglesplit"
          "$mod, t, togglefloating"
          "$mod, f, fullscreen"
          "$mod, g, togglegroup"
          "$mod, P, pseudo"

          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"
          "$mod SHIFT, L, changegroupactive, f"
          "$mod SHIFT, H, changegroupactive, b"

          "$mod ALT, ,resizeactive,"
          "$mod SHIFT, z, movetoworkspace, special"
          "$mod, z, togglespecialworkspace, special"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
  };

  # Hyprlock
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };

      background = lib.mkForce [
        {
          path = "~/wallpapers/everforest.jpg";
        }
      ];

      # input-field = [{
      #       size = "200, 50";
      #       position = "0, 0";
      #       monitor = "";
      #       dots_center = true;
      #       fade_on_empty = false;
      #       font_color = "rgb(202, 211, 245)";
      #       inner_color = "rgb(91, 96, 120)";
      #       outer_color = "rgb(24, 25, 38)";
      #       outline_thickness = 5;
      #       shadow_passes = 2;
      # }];
    };
  };

  # Hyprpaper
  services.hyprpaper = {
    package = pkgs.hyprpaper;
    enable = true;
    settings = {
      ipc = "off";
      splash = "false";

      preload = lib.mkForce [
        # "~/wallpapers/ruin.jpg"
        # "~/wallpapers/mimir.jpg"
        # "~/wallpapers/harvest.jpg"
        # "~/wallpapers/trashfire.webp"
        # "~/wallpapers/lostconstellation.jpg"
        # "~/wallpapers/everforest.jpg"
        # "~/wallpapers/evererforest.jpg"
        # "~/wallpapers/NITWgreggrulzok.jpg"
        "~/wallpapers/nitwcitynight.jpg"
        # "~/wallpapers/nitwwitchdaggah.jpg"
        # "~/wallpapers/greggroof.jpg"
      ];

      wallpaper = lib.mkForce [
        # "eDP-1,~/wallpapers/ruin.jpg"
        # "eDP-1,~/wallpapers/mimir.jpg"
        # "eDP-1,~/wallpapers/harvest.jpg"
        # "eDP-1,~/wallpapers/trashfire.webp"
        # "eDP-1,~/wallpapers/lostconstellation.jpg"
        # "eDP-1, ~/wallpapers/everforest.jpg"
        # "eDP-1, ~/wallpapers/evererforest.jpg"
        # "eDP-1, ~/wallpapers/NITWgreggrulzok.jpg"
        # "eDP-1, ~/wallpapers/greggroof.jpg"
        "eDP-1, ~/wallpapers/nitwcitynight.jpg"
        # "eDP-1, ~/wallpapers/nitwwitchdaggah.jpg"
        # "HDMI-A-1,~/wallpapers/ruin.jpg"
        # "HDMI-A-1,~/wallpapers/mimir.jpg"
        # "HDMI-A-1,~/wallpapers/harvest.jpg"
        # "HDMI-A-1,~/wallpapers/trashfire.webp"
        # "HDMI-A-1,~/wallpapers/lostconstellation.jpg"
        # "HDMI-A-1, ~/wallpapers/everforest.jpg"
        # "HDMI-A-1, ~/wallpapers/evererforest.jpg"
        # "HDMI-A-1, ~/wallpapers/NITWgreggrulzok.jpg"
        # "HDMI-A-1, ~/wallpapers/greggroof.jpg"
        "HDMI-A-1, ~/wallpapers/nitwcitynight.jpg"
        # "HMDI-A-1, ~/wallpapers/nitwwitchdaggah.jpg"
      ];
    };
  };
}
