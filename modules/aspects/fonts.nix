{
  den.aspects.fonts = {
    nixos = {pkgs, ...}: {
      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        texlivePackages.nunito
        ia-writer-mono
        source-han-sans
      ];
    };
  };
}
