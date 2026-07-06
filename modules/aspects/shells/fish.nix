{
  den.aspects.shells.fish = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        any-nix-shell # compatibility for `nix run` and `nix-shell`
        zoxide
      ];

      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting
          direnv hook fish | source
          zoxide init --cmd cd fish | source
        '';

        plugins = [
          {
            name = "tide";
            src = pkgs.fishPlugins.tide.src;
          }
          {
            name = "done";
            src = pkgs.fishPlugins.done.src;
          }
          {
            name = "autopair";
            src = pkgs.fishPlugins.autopair.src;
          }
        ];

        shellAliases = {
          neofetch = "fastfetch";

          update = "sudo nixos-rebuild switch --flake /etc/nixos/#default --impure --upgrade";

          zj = "zellij";
          zja = "zellij attach";
        };
      };
    };
  };
}
