{
  den.aspects.terminals.kitty = {host}: {
    homeManager = {
      programs.kitty = {
        enable = true;
        settings = {
          enable_audio_bell = false;
          cursor_shape = "block";
          cursor_shape_unfocused = "hollow";
          cursor_beam_thickness = 2;
          cursor_trail = 1;
          cursor_trail_decay = "0.1 0.4";
          cursor_trail_start_threshold = 0;
          cursor_blink_interval = 0;

          window_padding_width = 4;

          remember_window_size = true;
          resize_in_steps = true;

          shell = host.shell;
        };

        shellIntegration = {
          enableFishIntegration = true;
          mode = "no-cursor";
        };
      };
    };
  };
}
