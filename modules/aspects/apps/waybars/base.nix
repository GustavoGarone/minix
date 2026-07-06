{den, ...}: {
  den.aspects.apps.waybar = {host, ...}: {
    includes = with den.aspects.apps.waybar; [
      (
        if host.isLaptop
        then modules.laptop
        else modules.desktop
      )
    ];

    homeManager = {
      programs.waybar = {
        enable = true;
        settings = {
          main = {
            layer = "top";
            position = "right";
            width = 30;
            fixed-center = true;
            spacing = 10;

            modules-left = [
              "custom/os"
              "hyprland/workspaces"
              "niri/workspaces"
            ];
            modules-center = ["clock"];

            tray.spacing = 10;

            "hyprland/language" = {
              format-pt = "br";
              format-en = "en";
            };
            "hyprland/workspaces" = {
              format = "{icon}";
              format-icons = {
                active = "■";
                default = "□";
              };
            };

            "niri/workspaces" = {
              format = "{icon}";
              format-icons = {
                active = "■";
                default = "□";
              };
            };
            "niri/language" = {
              format-pt = "br";
              format-en = "en";
            };

            privacy = {
              icon-size = 14;
              modules = [{type = "screenshare";}];
            };
            battery = {
              interval = 60;
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{icon}";
              tooltip-format = "{capacity}% ({timeTo})";
              format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
              format-time = "{H}h {M}m";
              max-length = 25;
            };
            network = {
              format = "";
              format-disconnected = "";
            };
            clock = {
              format = "{:%H\n%M}";
              format-alt = "{:%H\n%M}";
              tooltip-format = "<tt>{calendar}</tt>";
              locale = "en_US.UTF-8";
              calendar = {
                mode-mon-col = 3;
                format = {
                  months = "<span color='#ffead3'><b>{}</b></span>";
                  days = "<span color='#ecc6d9'><b>{}</b></span>";
                  weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                  today = "<span color='#ff6699'><b><u>{}</u></b></span>";
                };
              };
              actions = {
                on-click-right = "mode";
                on-scroll-up = "shift_up";
                on-scroll-down = "shift_down";
              };
            };
            bluetooth = {
              format = "{status} 󰂯";
              format-connected = "{device_alias} 󰂱";
              format-on = "󰂯";
              format-off = "󰂲";
              format-disabled = "󰂲";
            };
            "custom/os" = {
              format = "🍃";
              on-click = "waypaper";
              tooltip = false;
            };
            "backlight/slider" = {
              orientation = "vertical";
            };
            "group/brightness" = {
              "orientation" = "inherit";
              modules = ["custom/sun" "backlight/slider"];
              drawer.transition-left-to-right = false;
            };
            "pulseaudio" = {
              format = "󰕾  {volume}%";
              format-bluetooth = "󰕾  {volume}% ";
              format-muted = "󰸈 ";
              on-click-right = "pavucontrol";
              on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            };
            mpris = {
              format = "{artist} {status_icon} {title}";
              format-paused = "{artist} {status_icon} {title}";
              interval = 1;
              rotate = 270;
              status-icons = {
                playing = " ";
                paused = " ";
                stopped = " ";
              };
            };
          };
        };

        style = ''
          window#waybar {
            background-color: @base00;
            color: @base05;
          }

          .modules-left,
          .modules-center,
          .modules-right {
            margin-top: 0px;
          }

          .modules-left {
            padding-top: 5px;
          }

          .modules-right {
            padding-bottom: 5px;
          }

          #workspaces {
            margin-bottom: 5px;
          }

          #workspaces button {
            all: unset;
            padding-right: 0px;
            margin-bottom: 0px;
            font-size: 12px;
            transition: all .1s ease;
            opacity: 0.5;
          }

          #workspaces button.active {
            opacity: 1;
          }

          #backlight-slider slider {
            min-height: 0;
            min-width: 0;
            opacity: 0;
            background-image: none;
            border: none;
            box-shadow: none;
            background: none;
          }

          #backlight-slider trough {
            min-width: 10px;
            min-height: 80px;
            background: @base01;
            border: 0;
            border-radius: 0;
          }

          #backlight-slider highlight {
            min-height: 10px;
            min-width: 10px;
            border-radius: 0;
            background: @base05;
            border: 0;
          }

          #battery .charging {
            color: @base0B;
          }

          #tray * {
            border-radius: 0;
          }
        '';
      };
    };
  };
}
