{
  den.aspects.apps.zellij = {host, ...}: {
    homeManager = {
      programs.zellij = {
        enable = true;
        settings = {
          pane_frames = false;
          show_startup_tips = false;
          simplified_ui = true;
          default_shell = host.shell;
        };
      };
    };
  };
}
