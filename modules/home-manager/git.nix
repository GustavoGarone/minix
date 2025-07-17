{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Gustavo Garone";
    userEmail = "gustavogarone@protonmail.com";
  };
  home.packages = with pkgs; [
    gh
    lazygit
  ];
}
