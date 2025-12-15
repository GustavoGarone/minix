{lib, ...}: {
  programs.kitty = {
    enable = true;
    settings = {
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 0;
    };
    font = {
      name = lib.mkForce "VictorMono NF";
      size = lib.mkForce 10.5;
    };
  };
}
