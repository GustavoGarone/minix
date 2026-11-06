{inputs, ...}: {
  den.aspects.apps.claude-code.homeManager = {
    pkgs,
    lib,
    ...
  }: let
    # Status line: model effort │ folder │ ctx % │ 5h · 7d rate limits
    statusline = pkgs.writeShellApplication {
      name = "claude-statusline";
      runtimeInputs = [pkgs.jq];
      text = ''
        sep=$' \e[2m│\e[0m '
        bold=$'\e[1m' cyan=$'\e[36m' mag=$'\e[35m' rst=$'\e[0m'

        IFS=$'\x1f' read -r model effort dir ctx five week < <(
          jq -r '
            def pct: if . == null then "" else (round | tostring) end;
            (.workspace.current_dir // .cwd // env.PWD) as $d
            | [ .model.display_name // "Claude",
                .effort.level // "",
                (if $d == env.HOME then "~" else ($d | split("/") | last) end),
                (.context_window.used_percentage | pct),
                (.rate_limits.five_hour.used_percentage | pct),
                (.rate_limits.seven_day.used_percentage | pct) ]
            | join("\u001f")' 2>/dev/null
        ) || true

        pct() {
          local c=$rst
          if [ "$2" -ge 90 ]; then c=$'\e[31m'; elif [ "$2" -ge 70 ]; then c=$'\e[33m'; fi
          printf '%s %s%s%%%s' "$1" "$c" "$2" "$rst"
        }

        if [ -z "$model" ]; then model=Claude; fi
        out="$bold$model$rst"
        if [ -n "$effort" ]; then out+=" $mag$effort$rst"; fi
        out+="$sep$cyan$dir$rst"
        if [ -n "$ctx" ]; then out+="$sep$(pct ctx "$ctx")"; fi

        limits=""
        if [ -n "$five" ]; then limits=$(pct 5h "$five"); fi
        if [ -n "$week" ]; then
          if [ -n "$limits" ]; then limits+=" · "; fi
          limits+=$(pct 7d "$week")
        fi
        if [ -n "$limits" ]; then out+="$sep$limits"; fi

        printf '%s' "$out"
      '';
    };
    statusLine = {
      type = "command";
      command = lib.getExe statusline;
    };
    # Merge statusLine into settings.json instead of owning the whole file:
    # Claude Code writes to it at runtime (/model, /config), so it must stay mutable.
    mergeSettings = pkgs.writeShellScript "claude-merge-settings" ''
      set -eu
      settings="$HOME/.claude/settings.json"
      mkdir -p "$HOME/.claude"
      [ -s "$settings" ] || echo '{}' > "$settings"
      tmp=$(mktemp)
      trap 'rm -f "$tmp"' EXIT
      ${lib.getExe pkgs.jq} --argjson sl ${lib.escapeShellArg (builtins.toJSON statusLine)} \
        '.statusLine = $sl' "$settings" > "$tmp"
      cat "$tmp" > "$settings"
    '';
  in {
    home.packages = [
      inputs.claude-code-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    home.activation.claudeStatusLine = lib.hm.dag.entryAfter ["writeBoundary"] ''
      run ${mergeSettings}
    '';
  };

  den.aspects.apps.claude-science.homeManager = {pkgs, ...}: {
    home.packages = [
      inputs.claude-science-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  den.aspects.apps.claude-desktop.nixos = {pkgs, ...}: {
    imports = [inputs.claude-desktop-nix-flake.nixosModules.default];
    programs.claude-desktop = {
      enable = true;
      package = inputs.claude-desktop-nix-flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
}
