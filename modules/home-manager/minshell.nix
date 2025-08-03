{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.minshell.packages.${system}.default
  ];
}
