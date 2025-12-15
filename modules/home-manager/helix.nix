{pkgs, ...}: {
  programs.helix = {
    enable = true;

    settings = {
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        rulers = [
          80
          120
        ];
        inline-diagnostics = {
          cursor-line = "warning";
        };
        end-of-line-diagnostics = "hint";
        cursorline = true;
        true-color = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          character = "•";
          render = true;
        };
        lsp = {
          auto-signature-help = false;
          display-messages = true;
        };
        statusline = {
          left = [
            "mode"
            "spinner"
            "version-control"
            "file-name"
          ];
        };
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
          space = {
            x = ":bc";
            X = ":bc!";
          };
        };
        select = {
          x = "select_line_below";
          X = "select_line_above";
          A-' = "switch_to_uppercase";
        };
      };
    };
    languages.language = [
      {
        name = "julia";
        # language-servers = ["jetls"];
        auto-format = true;
        formatter.command = "jlfmt";
        formatter.args = ["--style=sciml"];
      }
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
      }
    ];
    # languages.language-server = {
    #   jetls = {
    #     command = "jetls";
    #     args = ["--threads=auto" "--"];
    #   };
    # };
  };
}
