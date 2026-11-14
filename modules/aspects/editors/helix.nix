{inputs, ...}: let
  # Public key of the jetls-nix Cachix cache. Set to null to stop using the
  # cache (JETLS is then built locally).
  jetlsCacheKey = "jetls-nix.cachix.org-1:NV1wdLix0eRK1BXK+kslibtvBJqKc4DQ7RBcMHByIgs=";
in {
  den.aspects.editors.helix = {
    nixos = {
      pkgs,
      lib,
      ...
    }: {
      environment.systemPackages = with pkgs; [
        helix
        nil
        alejandra
      ];

      nix.settings = lib.mkIf (jetlsCacheKey != null) {
        substituters = ["https://jetls-nix.cachix.org"];
        trusted-public-keys = [jetlsCacheKey];
      };
    };

    homeManager = {
      pkgs,
      lib,
      ...
    }: let
      # JETLS, jlfmt and Julia built from the nixpkgs pin matching this
      # system's NixOS release, so they come from the cache.
      julia = inputs.jetls-nix.lib.packagesFor pkgs;
    in {
      programs.helix = {
        enable = true;
        settings = {
          editor = {
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
            indent-guides = {
              character = "•";
              render = true;
            };
            rulers = [
              80
              120
            ];
            line-number = "relative";
            bufferline = "multiple";
            cursorline = true;
            true-color = true;
            popup-border = "all";
            scrolloff = 8;
            file-picker.hidden = false;
            end-of-line-diagnostics = "hint";
            inline-diagnostics.cursor-line = "warning";
          };

          keys = {
            normal = {
              esc = [
                "collapse_selection"
                "keep_primary_selection"
              ];
              x = "select_line_below";
              X = "select_line_above";
              A-' = "switch_to_uppercase";
              space.x = ":bc";
              space.X = ":bc!";
              space.e = let
                unique-file = "/tmp/unique-file";
              in [
                ":sh rm -f ${unique-file}"
                ":insert-output yazi \"%{buffer_name}\" --chooser-file=${unique-file}"
                ":sh printf \"\\x1b[?1049h\\x1b[?2004h\" > /dev/tty"
                ":open %sh{cat ${unique-file}}"
                ":redraw"
                ":set-option mouse false"
                ":set-option mouse true"
              ];
            };
            select = {
              x = "select_line_below";
              X = "select_line_above";
              A-' = "switch_to_uppercase";
            };
            insert = {
              C-space = "completion";
            };
          };
        };

        languages = {
          language-server.jetls = {
            command = lib.getExe julia.jetls;
            args = ["serve"];
          };
          language = [
            {
              # Replaces the built-in LanguageServer.jl entry, which hangs on Julia 1.12+.
              name = "julia";
              language-servers = ["jetls"];
              auto-format = true;
              formatter.command = lib.getExe julia.jlfmt;
            }
            {
              name = "nix";
              auto-format = true;
              formatter.command = "alejandra";
            }
            {
              name = "go";
              auto-format = true;
              formatter.command = "goimports";
            }
            {
              name = "rust";
              auto-format = true;
              formatter.command = "rustfmt";
            }
          ];
        };
      };
    };
  };
}
