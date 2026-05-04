{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "html"
      "r"
      "julia"
      "quarto"
      "nix"
    ];

    userSettings = {
      helix_mode = true;
      inline_code_actions = true;
      editpredictions.mode = "subtle";
      calls.mute_on_join = true;
      git = {
        branch_picker.show_author_name = true;
        inline_blame.show_commit_summary = true;
      };
      collaboration_panel.dock = "right";
      gutter.min_line_number_digits = 2;
      diagnostics.inline.enabled = true;
      relative_line_numbers = "enabled";
      terminal.shell.program = "fish";
    };
  };
}
