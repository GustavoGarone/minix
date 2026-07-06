{
  den.aspects.utils = {host}: {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        uutils-coreutils-noprefix
        eza
        ripgrep
        ripgrep-all
        fd
        zoxide
        bat
      ];

      home.shellAliases = {
        ls = "eza --icons=auto";
        ll = "eza --icons=auto -l";
        tree = "eza --icons=auto -T";

        cat = "bat";
        grep = "rg";
        grepa = "rga";
        find = "fd";
      };
    };
  };
}
