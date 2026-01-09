{pkgs, ...}: {
  home.packages = with pkgs; [
    julia-bin
  ];
  home.sessionPath = [
    "/home/minze/.julia/bin"
  ];
}
