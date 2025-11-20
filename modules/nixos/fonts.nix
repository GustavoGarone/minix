{pkgs, ...}: {
  fonts.packages = with pkgs; [
    vista-fonts
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
    texlivePackages.nunito
  ];
  # For specifics overrides
  # fonts.packages = [ ] ++ builtins.filter.lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
