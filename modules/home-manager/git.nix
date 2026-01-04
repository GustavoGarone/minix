{pkgs, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Gustavo Garone";
        email = "gustavogarone@protonmail.com";
        signingkey = "A689A86A2F82A235";
      };
      commit = {
        gpgSign = true;
      };
    };
  };
  home.packages = with pkgs; [
    gh
    lazygit
  ];
}
