{
  den.aspects.fonts = {
    nixos = {pkgs, ...}: {
      fonts.packages = with pkgs; [
        ttf_bitstream_vera
        nerd-fonts.jetbrains-mono
        texlivePackages.nunito
        ia-writer-mono
        source-han-sans
      ];
    };
  };
}
