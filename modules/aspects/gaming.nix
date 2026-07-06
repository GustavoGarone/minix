{
  den.aspects.gaming = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        mangohud
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
    };
  };
}
