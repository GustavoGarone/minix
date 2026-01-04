{...}: {
  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
      insensitive = true;
    };
  };
}
