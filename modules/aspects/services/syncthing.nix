{
  den.aspects.services.syncthing = {
    host,
    user,
  }: {
    homeManager = {config, ...}: {
      services.syncthing = {
        enable = true;
        overrideDevices = true;
        overrideFolders = true;

        settings = {
          devices = {
            homelab.id = "5RQIVQG-E2NRJEB-YCSBR6A-JGPCGB5-OA3L7PR-SSUMHTG-JBBV4U6-65WVEAC";
          };

          folders = {
            minzidian = {
              path = "${config.xdg.userDirs.documents}/obsidian/personal";
              devices = ["homelab"];
            };
          };

          options.urAccepted = -1;
          gui.theme = "black";
        };
      };
    };
  };
}
