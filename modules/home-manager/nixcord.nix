{inputs, ...}: {
  programs.nixcord = {
    enable = true; # enable Nixcord. Also installs discord package
    config = {
      # frameless = true; # set some Vencord options
      plugins = {
        fakeNitro.enable = true;
        volumeBooster.enable = true;
        youtubeAdblock.enable = true;
      };
    };
  };
}
