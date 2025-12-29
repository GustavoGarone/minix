{...}: {
  programs.waybar = {
    enable = true;
    settings = {
      main = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [
          # "custom/os"
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "network"
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

        # Custom modules
        "custom/os" = {
          "format" = "";
        };
      };
    };

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

      '';
  };
}
