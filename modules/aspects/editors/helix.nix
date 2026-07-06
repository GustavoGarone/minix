{
  den.aspects.editors.helix = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        helix
        nil
        alejandra
      ];
    };

    homeManager = {pkgs, ...}: {
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
          language = [
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
