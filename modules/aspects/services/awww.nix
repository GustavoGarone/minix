{
  den.aspects.services.awww = {
    homeManager = {pkgs, ...}: {
      services.awww.enable = true;
      home.packages = [pkgs.waypaper];
    };
  };
}
