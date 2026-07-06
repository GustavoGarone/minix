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
            position = "top";
            height = 30;
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
              hide-empty = true;
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
              format = "{capacity}% {icon}";
              tooltip-format = "{capacity}% ({timeTo})";
              format-icons = {
                default = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
                charging = ["󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
              };
              format-time = "{H}h {M}m";
              max-length = 25;
            };
            network = {
              format = "";
              format-disconnected = "";
            };
            clock = {
              format = "{:%H:%M}";
              format-alt = "{:%H:%M}";
              tooltip-format = "<tt>{calendar}</tt>";
              locale = "pt_BR.UTF-8";
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
              min = 1;
              orientation = "horizontal";
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
              status-icons = {
                playing = " ";
                paused = " ";
                stopped = " ";
              };
            };
          };
        };

        style = ''
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

          #backlight-slider slider {
            min-height: 0px;
            min-width: 0px;
            opacity: 0;
            background-image: none;
            border: none;
            box-shadow: none;
            background: none;
          }

          #backlight-slider trough {
            min-height: 10px;
            min-width: 80px;
            border-radius: 5px;
            background: black;
          }

          #backlight-slider highlight {
            min-width: 10px;
            border-radius: 5px;
            background: #f9ebd8;
          }

        '';
      };
    };
  };
}
