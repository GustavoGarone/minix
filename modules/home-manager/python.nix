{pkgs, ...}: {
  home.packages = with pkgs; [
    (python313.withPackages (ppkgs: [
      ppkgs.pynvim
    ]))
  ];
}
