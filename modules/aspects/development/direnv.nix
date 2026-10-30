{
  den.aspects.development.direnv = {
    homeManager = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        config.global.log_filter = "^loading|^unloading";
      };
    };
  };
}
