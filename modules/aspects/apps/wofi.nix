{
  den.aspects.apps.wofi = {host, ...}: {
    homeManager = {
      programs.wofi = {
        enable = true;
        settings = {
          width = 800;
          allow_images = true;
          image_size = 40;
          term = host.terminal;
          insensitive = true;
          location = "center";
          normal_window = false;
          prompt = "search";
          lines = 10;
          hide_scroll = true;
          no_actions = true;
        };

        style = ''
          #input {
            margin: 10px;
            border-radius: 12;
          }

          #scroll {
            margin: 0 10px;
            margin-bottom: 10px;
          }

          #entry {
            outline: none;
            padding: 5px;
          }

          #img {
            margin-right: 10px;
          }
        '';
      };
    };
  };
}
