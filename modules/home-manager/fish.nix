{pkgs, ...}: {
  home.packages = with pkgs; [
    # Fish
    fishPlugins.done
    fishPlugins.fzf
    fishPlugins.grc
    grc
    any-nix-shell
    fishPlugins.z
    fishPlugins.spark
    fishPlugins.colored-man-pages
    fishPlugins.tide
    fishPlugins.autopair
  ];
  programs.fish = {
    enable = true;
    # ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      zoxide init fish | source # config for zoxide
      direnv hook fish | source # Direnv shell hook
    '';
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      # {name = "z"; src = pkgs.fishPlugins.z.src;} # replaced by zoxide
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
    ];
    shellAliases = {
      neofetch = "fastfetch";
      ls = "eza --icons=auto";
      ll = "ls -l";
      cd = "z";
      update = "sudo nixos-rebuild switch --flake /etc/nixos/#default --impure --upgrade";
      rimworld = "steam-run ~/GOG\ Games/RimWorld/start.sh";
      cat = "bat";
      grep = "rg";
      grepa = "rga";
      find = "fd";
      diff = "delta";
      runic = "julia --project=@runic -e 'using Runic; exit(Runic.main(ARGS))' --";
    };
  };
}
