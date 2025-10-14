{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    # Codium doesn't work with live share
    # package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      julialang.language-julia
      reditorsupport.r
      ms-vsliveshare.vsliveshare
    ];
  };
}
