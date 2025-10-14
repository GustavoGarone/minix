{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  # Custom R Packages
  RwPkgs = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [
      languageserver
      ggplot2
      knitr
      rmarkdown
      quarto
      styler
      IRkernel
    ];
  };
  ark = pkgs.fetchFromGitHub {
    owner = "posit-dev";
    repo = "ark";
    rev = "latest";
    sha256 = "sha256-hRfB/AvRUWJfO96kESbU+jyCc+zl/5NB870STOGRF9k=";
  };
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manager
  imports = [
    ../modules/home-manager/hyprland.nix
    ../modules/home-manager/improvs.nix
    ../modules/home-manager/fish.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/kitty.nix
    ../modules/home-manager/rofi.nix
    ../modules/home-manager/gammastep.nix
    ../modules/home-manager/stylix.nix
    ../modules/home-manager/zen-browser.nix
    ../modules/home-manager/zed.nix
    ../modules/home-manager/codium.nix
    # ../modules/home-manager/dunst.nix
    # ../modules/home-manager/hyprpanel.nix
    ../modules/home-manager/minshell.nix
    ../modules/home-manager/nixcord.nix
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

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # "OS" Packages
    yazi
    powertop
    # rofi-wayland plugins. Rest of rofi defined in module
    # See https://discourse.nixos.org/t/rofi-emoji-plugin-instructions-dont-work-need-help/49696/4
    rofi-power-menu
    unzip
    distrobox
    wl-clipboard
    libnotify
    tree
    kdePackages.polkit-kde-agent-1
    jellyfin-ffmpeg
    hyperfine

    # Replacements for teminal utils
    uutils-coreutils-noprefix
    eza
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
    krita
    loupe
    thunderbird
    obsidian
    tokei
    mprocs
    wiki-tui
    evince
    grimblast
    libreoffice-qt
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

    # TODO: add separate files for different programing languages if you want
    # them in the system instead of dev envs.

    # Programming
    # Neovim # Defined in stylix.nix for stylix support
    quarto
    librsvg # converting plots to pdf
    julia-bin
    xeus # jupyteR kernel
    ark # idem
    (python313.withPackages (ppkgs: [
      ppkgs.pynvim
      ppkgs.flake8
      ppkgs.scipy
      ppkgs.black
      ppkgs.mdformat
      ppkgs.isort
      ppkgs.ipykernel
    ]))
    RwPkgs
    nil # Nix LS
    alejandra # Nix formatter
    # linters
    cpplint
    sqruff # SQL in Rust
    hlint
    shellcheck
    vale
    selene
    # linters ^
    # py packages
    gnumake
    texliveFull
    tex-fmt # Latex formatter in rust

    # For Fun
    nethack
    steam
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

  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
    };
  };

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

  home.sessionVariables = {
    EDITOR = "nvim";
    QT_QPA_PLATFORM = "wayland;xcb";
    R_HOME = "${pkgs.R}/lib/R";
    # LD_LIBRARY_PATH = "${pkgs.R}/lib/R/lib:$LD_LIBRARY_PATH";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
