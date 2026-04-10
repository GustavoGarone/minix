{pkgs, ...}: let
  shaders = pkgs.fetchFromGitHub {
    owner = "KroneCorylus";
    repo = "ghostty-shader-playground";
    rev = "main";
    sha256 = "sha256-Z3jF76MnyEGQuzfeZNTyOhpGAiGfhm6rnkdeBIpsJck=";
  };
  shader = name: "${shaders}/public/shaders/${name}.glsl";
in {
  programs.ghostty = {
    enable = true;
    settings = {
      shell-integration-features = "no-cursor";
      cursor-style = "block";
      link-previews = true;
      custom-shader = shader "cursor_smear";
      custom-shader-animation = true;
    };
  };
  wayland.windowManager.hyprland.settings.bind = [
    "$mod, q, exec, GTK_IM_MODULE=simple ghostty"
    "$mod, e, exec, GTK_IM_MODULE=simple ghostty -e yazi"
    "$CTRL SHIFT, Escape, exec, GTK_IM_MODULE=simple ghostty -e btop"
  ];
}
