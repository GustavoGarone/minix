{
  den.aspects.apps.prismlauncher = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.prismlauncher];
    };
  };
}
