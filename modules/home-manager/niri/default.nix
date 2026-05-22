{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    xwayland-satellite
    xdg-utils
  ];

  imports = [
    ./polkit.nix
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      binds = import ./binds.nix;

      input = {
        keyboard = {
          xkb = {
            layout = "br";
            options = "grp:win_space_toggle";
          };
          numlock = true;
          repeat-delay = 140;
          repeat-rate = 45;
        };

        mouse.accel-profile = "flat";
      };

      hotkey-overlay.skip-at-startup = false;
      screenshot-path = "~/pictures/screenshots/%Y-%m-%d %H-%M-%S.png";

      environment."NIXOS_OZONE_WL" = "1";

      layout = {
        gaps = 6;
        always-center-single-column = true;

        empty-workspace-above-first = true;

        preset-column-widths = [
          {proportion = 1. / 3.;}
          {proportion = 1. / 2.;}
          {proportion = 2. / 3.;}
        ];
        default-column-width = {proportion = 0.5;};

        focus-ring.enable = false;
        border = {
          enable = true;
          width = 1;
        };
      };

      spawn-at-startup = [
        {argv = ["${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"];}
        {argv = ["systemctl --user reset-failed waybar.service"];}
        {argv = ["pipewire & pipewire-pulse"];}
      ];
      prefer-no-csd = true;

      window-rules = [
        {
          matches = [
            {title = "Proton Pass";}
            {title = "Whatsapp";}
            {app-id = "io.ente.auth";}
            {app-id = "org.telegram.desktop";}
          ];
          block-out-from = "screencast";
        }
      ];
    };
  };
}
