{pkgs, ...}: {
  home.packages = with pkgs; [
    # Fish
    any-nix-shell
    fishPlugins.z
  ];
  programs.fish = {
    enable = true;
    # ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      zoxide init --cmd cd fish | source # config for zoxide
      direnv hook fish | source # Direnv shell hook
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
      ls = "eza --icons=auto";
      ll = "eza --icons=auto -l";
      tree = "eza --icons=auto -T";
      update = "sudo nixos-rebuild switch --flake /etc/nixos/#default --impure --upgrade";
      cat = "bat";
      grep = "rg";
      grepa = "rga";
      find = "fd";
      diff = "delta";
      zj = "zellij";
      zja = "zellij attach";
      runic = "julia --project=@runic -e 'using Runic; exit(Runic.main(ARGS))' --";
    };
  };
}
