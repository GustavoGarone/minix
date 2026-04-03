{lib, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      input = {
        kb_layout = "br";
        repeat_delay = 140;
        repeat_rate = 45;
      };

      general = {
        gaps_in = 1;
        gaps_out = 5;
        border_size = 0;
        layout = "dwindle";
      };

      env = [
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];

      decoration = {
        rounding = 3;
        blur.enabled = "true";
      };
      animations.enabled = "yes";
      animation = [
        "workspaces, 1, 2, default"
        "specialWorkspace, 1, 2, default, fade"
        "windows, 1, 2, default, popin"
        "border, 1, 2, default"
        "fade, 1, 2, default"
      ];

      monitor = [
        "eDP-1, 1920x1080@120, -1920x0, 1"
      ];

      exec-once = [
        "waybar"
        "bash -c 'dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user restart xdg-desktop-portal.service'"
        "hyprctl setcursor Bibata-Modern-Classic 14"
        "systemctl --user start hyprpolkitagent"
      ];
      "$mod" = "SUPER";
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind =
        [
          "$mod, a, exec, wofi --show drun --show-icons"
          "$mod, P, exec, hyprpicker -a"
          "$mod shift, p, exec, hyprpicker -a --format=hsl"
          "$mod SHIFT, M, exec, pkill Hyprland"
          "$mod SHIFT, l, exec, hyprlock"
          "$mod, s, exec, grimblast copy area --freeze"
          "$mod SHIFT, s, exec, grimblast save area --freeze"
          "$mod, q, exec, kitty"
          "$mod, e, exec, kitty yazi"
          "$CTRL SHIFT, Escape, exec, kitty btop"

          "$mod, c, killactive"
          "$mod, t, togglefloating"
          "$mod shift, t, pseudo"
          "$mod, f, fullscreen"
          "$mod, g, togglegroup"

          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"
          "$mod SHIFT, L, changegroupactive, f"
          "$mod SHIFT, H, changegroupactive, b"

          "$mod ALT, ,resizeactive,"
          "$mod SHIFT, z, movetoworkspace, special"
          "$mod, z, togglespecialworkspace, special"

          # Keyboard audio wheel
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
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
          path = "$HOME/wallpapers/everforest.jpg";
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

  # Authenticator
  services.hyprpolkitagent = {
    enable = true;
  };
}
