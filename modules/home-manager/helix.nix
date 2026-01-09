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
            "spinner"
            "mode"
            "separator"
            "spacer"
            "version-control"
          ];
          center = [
            "read-only-indicator"
            "file-modification-indicator"
            "file-name"
            "diagnostics"
          ];
          right = [
            "file-type"
            "separator"
            "selections"
            "register"
            "position"
            "file-encoding"
          ];
        };
        file-picker.hidden = false;
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
        name = "r";
        language-servers = ["air" "r"];
        auto-format = true;
      }
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
      }
      {
        name = "quarto";
        auto-format = true;
        language-servers = ["marksman"];
        # formatter.command = "mdformat"; # It sucks!
        # formatter.args = ["-"];
      }
      {
        name = "html";
        auto-format = true;
        language-servers = ["superhtml"];
      }
      {
        name = "markdown";
        auto-format = true;
        # formatter.command = "mdformat";
        # formatter.args = ["-"];
      }
    ];
    languages.language-server = {
      #   jetls = {
      #     command = "jetls";
      #     args = ["--threads=auto" "--"];
      #   };
      air = {
        command = "air";
        args = ["language-server"];
      };
    };
  };
  home.packages = with pkgs; [
    marksman
    alejandra
  ];
}
