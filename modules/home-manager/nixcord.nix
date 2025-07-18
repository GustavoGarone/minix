{inputs, ...}: {
  programs.nixcord = {
    enable = true; # enable Nixcord. Also installs discord package
    config = {
      # frameless = true; # set some Vencord options
      plugins = {
        hideAttachments.enable = true; # Enable a Vencord plugin
        fakeNitro.enable = true;
        volumeBooster.enable = true;
        youtubeAdblock.enable = true;
      };
    };
  };
}
