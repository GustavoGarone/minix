{
  inputs,
  den,
  ...
}: let
  namespace = inputs.den.namespace;
in {
  _module.args.__findFile = den.lib.__findFile;
  imports = [
    (namespace "laptop" true)
    (namespace "desktop" true)

    inputs.den.flakeModule
  ];

  # Allows you to nix run
  perSystem = {pkgs, ...}: {
    packages = den.lib.nh.denPackages {fromFlake = true;} pkgs;
  };
}
