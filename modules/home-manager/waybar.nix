{pkgs, ...}: {
  home.packages = with pkgs; [
    playerctl
  ];
  programs.waybar = {
    enable = true;
    settings = {
      main = {
        layer = "bottom";
        position = "top";
        height = 30;
        modules-left = [
          "custom/os"
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "mpris"
          "tray"
          "network"
          "pulseaudio"
          "battery"
        ];

        # Module configuration
        "clock" = {
          format-alt = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-clck-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "mpris" = {
          format = "{artist} {player_icon} {title}";
          format-paused = "{artist} {status_icon} {title}";
          interval = 1;
          player-icons = {
            chromium = "󰼮 ";
            firefox = " ";
            default = " ";
          };
          status-icons = {
            playing = " ";
            paused = " ";
            stopped = " ";
          };
        };

        "network" = {
          format-wifi = "  ";
          format-ethernet = "󰈀 ";
        };

        "pulseaudio" = {
          format = "󰕾  {volume}%";
          format-bluetooth = "󰕾  {volume}% ";
          format-muted = "󰸈 ";
          on-click-right = "pavucontrol";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        # Custom modules
        "custom/os" = {
          format = "🍃";
          on-click = "waypaper";
        };
      };
    };

    # CSS
    style =
      # css
      ''
        * {
          border: none;
          border-radius: 0;
          font-family: Nunito, Symbols-Only;
        }

        .modules-center {
          background-color: rgba(0,0,0,0);
        }

        .modules-right {
          padding: 0px 2px;
        }

        #clock {
          font-weight: bold;
        }

        #network.disconnected {
          opacity: 0.5
        }

        .modules-right > * > * {
          margin: 0px 5px;
        }

      '';
  };
}
