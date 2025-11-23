{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.tidaLuna.packages.${system}.default
  ];
}
