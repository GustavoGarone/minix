{pkgs, ...}: {
  programs.nixcord = {
    enable = true; # enable Nixcord. Also installs discord package
    vesktop.enable = true;
    config = {
      # frameless = true; # set some Vencord options
      themeLinks = [
        "https://github.com/marciosobel/vekstop-custom-fonts/blob/dev/themes/my-fonts.css"
      ];
      plugins = {
        fakeNitro.enable = true;
        volumeBooster.enable = true;
        youtubeAdblock.enable = true;
      };
    };
  };
  programs.vesktop = {
    enable = false;
  };
  home.packages = with pkgs; [
    legcord
  ];
}
