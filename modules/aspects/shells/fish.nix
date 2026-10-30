{
  den.aspects.shells.fish = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        any-nix-shell # compatibility for `nix run` and `nix-shell`
      ];

      programs.zoxide = {
        enable = true;
        options = ["--cmd" "cd"];
      };

      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting
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

          update = "nix flake update --flake /home/minze/minix && sudo nixos-rebuild switch --flake /home/minze/minix";

          zj = "zellij";
          zja = "zellij attach";
        };
      };
    };
  };
}
