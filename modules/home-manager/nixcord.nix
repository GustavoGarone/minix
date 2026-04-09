{
  programs.nixcord = {
    enable = true; # enable Nixcord. Also installs discord package
    discord.enable = false;
    vesktop.enable = true;
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
