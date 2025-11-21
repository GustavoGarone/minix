{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.caelestia-stylix-sync;

  # The script that handles the sync
  syncScript = pkgs.writeShellScriptBin "caelestia-stylix-sync" ''
    set -euo pipefail

    CAELESTIA_CONFIG="$HOME/.config/caelestia/shell.json"
    STYLIX_IMAGE_FILE="/etc/stylix/caelestia-current-wallpaper"

    if [[ ! -f "$CAELESTIA_CONFIG" ]]; then
      echo "Caelestia config not found at $CAELESTIA_CONFIG"
      exit 1
    fi

    # Extract current wallpaper path from Caelestia config
    WALLPAPER_PATH=$(jq -r '.background.currentWallpaper // empty' "$CAELESTIA_CONFIG")

    if [[ -z "$WALLPAPER_PATH" || ! -f "$WALLPAPER_PATH" ]]; then
      echo "No valid wallpaper found in Caelestia config"
      exit 1
    fi

    # Check if wallpaper has changed
    CURRENT_LINK=$(readlink "$STYLIX_IMAGE_FILE" 2>/dev/null || echo "")
    if [[ "$CURRENT_LINK" == "$WALLPAPER_PATH" ]]; then
      echo "Wallpaper unchanged, skipping rebuild"
      exit 0
    fi

    echo "Wallpaper changed to: $WALLPAPER_PATH"

    # Update the symlink
    sudo mkdir -p /etc/stylix
    sudo ln -sf "$WALLPAPER_PATH" "$STYLIX_IMAGE_FILE"

    # Trigger rebuild
    echo "Triggering NixOS rebuild..."
    sudo nixos-rebuild switch --flake "/etc/nixos#$(hostname)" --option accept-flake-config true
  '';

  # Service that watches for Caelestia config changes
  watcherService = pkgs.writeShellScriptBin "caelestia-stylix-watcher" ''
    while true; do
      # Watch for file modifications
      inotifywait -e modify -e create -e delete \
        "$HOME/.config/caelestia/shell.json" \
        "$HOME/.config/caelestia" 2>/dev/null || true

      # Small delay to ensure Caelestia has finished writing
      sleep 2

      # Run the sync script
      ${syncScript}/bin/caelestia-stylix-sync || echo "Sync failed, continuing..."
    done
  '';
in {
  options.services.caelestia-stylix-sync = {
    enable = lib.mkEnableOption "Caelestia-Stylix wallpaper synchronization";
    user = lib.mkOption {
      type = lib.types.str;
      default = "your-username";
      description = "User running Caelestia";
    };
  };

  config = lib.mkIf cfg.enable {
    # Configure Stylix to use the synced wallpaper
    stylix.image = lib.mkDefault "/etc/stylix/caelestia-current-wallpaper";

    # Systemd service to watch for wallpaper changes
    systemd.user.services.caelestia-stylix-watcher = {
      unitConfig = {
        Description = "Caelestia-Stylix Wallpaper Sync";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };

      serviceConfig = {
        Type = "simple";
        ExecStart = "${watcherService}/bin/caelestia-stylix-watcher";
        Restart = "on-failure";
        RestartSec = 5;
      };

      wantedBy = ["graphical-session.target"];
    };

    # Ensure required packages are available
    environment.systemPackages = with pkgs; [
      jq
      inotify-tools
      syncScript
    ];

    # Allow the user to run nixos-rebuild without password
    security.sudo.extraRules = [
      {
        users = [cfg.user];
        commands = [
          {
            command = "${config.system.build.nixos-rebuild}/bin/nixos-rebuild";
            options = ["NOPASSWD"];
          }
          {
            command = "/bin/ln";
            options = ["NOPASSWD"];
          }
          {
            command = "/bin/mkdir";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };
}
