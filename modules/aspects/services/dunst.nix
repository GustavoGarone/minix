{
  den.aspects.services.dunst = {
    homeManager = {
      services.dunst = {
        enable = true;
        settings = {
          global = {
            follow = "keyboard";
            width = "(300, 500)";
            frame_width = 1;
            notification_limit = 5;
            origin = "bottom-right";
            offset = "(15, 15)";

            corner_radius = 0;
            icon_corner_radius = 0;
            gap_size = 1;

            format = "<i>%a</i>\n<b>%s</b>\n%b";
            stack_duplicates = true;
            enable_recursive_icon_lookup = true;

            max_icon_size = 64;
            min_icon_size = 64;
            icon_position = "left";
          };
        };
      };
    };
  };
}
