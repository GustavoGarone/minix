{pkgs, ...}: {
  # This module exists to facilitate plugin configuring.
  home.packages = with pkgs; [
    gimp-with-plugins
  ];
}
