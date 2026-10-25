{
  den.aspects.apps.pianoteq = {
    homeManager = {
      config,
      pkgs,
      ...
    }: let
      home = config.home.homeDirectory;
      launcher = pkgs.writeShellApplication {
        name = "pianoteq";
        runtimeInputs = [pkgs.umu-launcher];
        # This is, of course, computer dependant. I'd like to make this
        # Fully reproducible in the future.
        text = ''
          export WINEPREFIX="${home}/.local/share/Steam/steamapps/compatdata/2293400448/pfx"
          export PROTONPATH="${home}/.local/share/Steam/compatibilitytools.d/GE-Proton11-1"
          export GAMEID=umu-default
          export MDRT_DIRECT2D=0
          export PROTON_USE_XALIA=0
          export PROTON_ENABLE_WAYLAND=0
          export PROTON_USE_WAYLAND=0

          app_dir='/mnt/hdnixos/programs/Pianoteq 9'
          test -f "$app_dir/Pianoteq 9.exe"
          test -d "$WINEPREFIX"
          test -f "$PROTONPATH/proton"
          cd "$app_dir"
          exec umu-run "$app_dir/Pianoteq 9.exe" "$@"
        '';
      };
    in {
      home.packages = [launcher];
      xdg.desktopEntries.pianoteq = {
        name = "Pianoteq 9";
        comment = "Play Pianoteq with Proton";
        exec = "${launcher}/bin/pianoteq";
        icon = "audio-x-generic";
        terminal = false;
        categories = ["AudioVideo" "Audio" "Midi"];
      };
    };
  };
}
