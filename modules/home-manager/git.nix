{pkgs, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Gustavo Garone";
        email = "gustavogarone@protonmail.com";
      };
    };
  };
  home.packages = with pkgs; [
    gh
    lazygit
  ];
}
