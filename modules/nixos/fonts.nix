{pkgs, ...}: {
  fonts.packages = with pkgs; [
    vistafonts
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
  ];
  # For specifics overrides
  # fonts.packages = [ ] ++ builtins.filter.lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
