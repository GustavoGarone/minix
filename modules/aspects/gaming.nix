{
  den.aspects.gaming = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        mangohud
        (heroic.override {
          extraPkgs = pkgs':
            with pkgs'; [
              gamescope
              gamemode
            ];
        })
      ];

      programs.steam = {
        enable = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };

      programs.gamemode.enable = true;
      programs.gamescope.enable = true;
    };
  };
}
