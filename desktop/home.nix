{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  nixvim-package = inputs.minvim.packages.${system}.default;
  extminvim = nixvim-package.extend config.lib.stylix.nixvim.config;
  # Custom R Packages
  RwPkgs = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [
      languageserver
      ggplot2
      knitr
      rmarkdown
      quarto
      # ggtikz
      # tikzDevice
      styler
    ];
  };
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manager
  imports = [
    ../modules/home-manager/hyprland.nix
    ../modules/home-manager/fish.nix
    ../modules/home-manager/git.nix
  ];

  home.username = "minze";
  home.homeDirectory = "/home/minze";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # "OS" Packages
    yazi
    # rofi-wayland plugins. Rest of rofi defined in module
    # See https://discourse.nixos.org/t/rofi-emoji-plugin-instructions-dont-work-need-help/49696/4
    rofi-power-menu
    # rofi-calc
    # rofi-emoji-wayland # DEFINED IN PLUGINS
    # rofi-wayland plugins ^
    unzip
    distrobox
    wl-clipboard
    libnotify
    tree
    kdePackages.polkit-kde-agent-1
    # mpd
    jellyfin-ffmpeg
    hyperfine

    # Replacements for teminal utils
    eza
    # (pkgs.uutils-coreutils.override { prefix = ""; })
    uutils-coreutils-noprefix
    ripgrep
    ripgrep-all
    fd
    zoxide
    bat
    delta
    qt6Packages.qtwayland
    qt6.qtwayland

    # General Software
    qbittorrent
    vlc
    inkscape
    tomato-c
    gcal
    drawing
    loupe
    thunderbird
    obsidian
    tokei
    mprocs
    wiki-tui
    evince
    grimblast
    libreoffice-qt
    # discord
    # vesktop
    zapzap
    btop
    kdePackages.dolphin
    kdePackages.qtsvg
    koodo-reader
    croc
    zotero
    pavucontrol
    librewolf
    hyprpicker

    # Programming
    # nvim-pkg # through kickstartnix.nvim and it's flakes in ~/.config/nixosvim/nvim-kickstart/
    extminvim
    # javascript :(
    prettierd
    # no more javascrit :)
    # pandoc_3_6
    quarto
    librsvg # converting plots to pdf
    chromium # Necessário para o quarto
    julia
    (python313.withPackages (ppkgs: [
      ppkgs.pynvim
      ppkgs.flake8
      ppkgs.black
      ppkgs.mdformat
      ppkgs.isort
      ppkgs.jupyter
      ppkgs.ipykernel
      ppkgs.jupyter-cache
    ]))
    RwPkgs
    nil # Nix LS
    alejandra
    nodejs
    # linters
    cpplint
    hlint
    shellcheck
    vale
    selene
    # linters ^
    # py packages
    gnumake
    # texliveFull
    tex-fmt # Latex formatter in rust

    # For Fun
    nethack
    steam-run
    (lutris.override {
      extraLibraries = pkgs: [
        # Extra packages for lutris dependencies
      ];
    })
    tidal-hifi
    wineWowPackages.waylandFull
    cbonsai
    cmatrix
    fastfetch

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # TODO: create a script for updating flakes and switching home-manager (do the same for sys)
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.zen-browser.enable = true;

  programs.nixcord = {
    enable = true; # enable Nixcord. Also installs discord package
    config = {
      # frameless = true; # set some Vencord options
      plugins = {
        hideAttachments.enable = true; # Enable a Vencord plugin
        fakeNitro.enable = true;
        volumeBooster.enable = true;
        youtubeAdblock.enable = true;
      };
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    # Currently not working due to lag-behind of rofi-wayland
    plugins = [
      pkgs.rofi-emoji-wayland
      # pkgs.rofi-power-menu
      # pkgs.rofi-calc
    ];
    # theme = lib.mkForce "/home/minze/.local/share/rofi/themes/catppuccin-mocha.rasi";
  };

  stylix = {
    enable = true;
    # image = ~/wallpapers/nitwcitynight.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    # polarity = "dark";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
    targets.hyprland = {
      enable = true;
      hyprpaper.enable = false;
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 0;
      font_size = 10.5;
    };
  };

  # Dunst notif daemon
  services.dunst = {
    enable = true;
  };
  services.gammastep = {
    enable = true;
    provider = "manual";
    tray = true;
    latitude = -23.00;
    longitude = -46.00;
    settings = {
      general.temp-night = lib.mkForce 3000;
    };
  };

  xdg.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-beta.desktop";
      "application/pdf" = "zen-beta.desktop";
      "image/png" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";
    };
  };

  # xdg.configFile = {
  #     "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  #     "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  #     "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  # };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/minze/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "palenight";
    QT_QPA_PLATFORM = "wayland;xcb";
    R_HOME = "${pkgs.R}/lib/R";
    LD_LIBRARY_PATH = "${pkgs.R}/lib/R/lib:$LD_LIBRARY_PATH";
    # QT_AUTO_SCREEN_SCALE_FACTOR=1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
