{
  den.aspects.development.postgresql = {host}: {
    nixos = {pkgs, ...}: {
      services.postgresql = {
        enable = true;
      };
    };
  };
}
