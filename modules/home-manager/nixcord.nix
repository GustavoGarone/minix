{
  programs.nixcord = {
    enable = true; # enable Nixcord. Also installs discord package
    discord = {
      enable = true;
      vencord.enable = true;
    };
    vesktop.enable = false;
    config = {
      plugins = {
        fakeNitro.enable = true;
        volumeBooster.enable = true;
        youtubeAdblock.enable = true;
        ClearURLs.enable = true;
      };
    };
  };
}
